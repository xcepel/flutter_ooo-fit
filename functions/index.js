const {onSchedule} = require("firebase-functions/v2/scheduler");
const functions = require("firebase-functions");
const admin = require("firebase-admin");

admin.initializeApp();

// scheduled to run every day at midnight
exports.updateLastWorn = onSchedule("every day 00:00", async (event) => {
  const db = admin.firestore();

  try {
    // get past events
    const now = admin.firestore.Timestamp.now();
    const eventsSnapshot = await db
        .collection("events")
        .where("eventDatetime", "<", now)
        .get();

    if (eventsSnapshot.empty) {
      console.log("No past events found.");
      return null;
    }

    const outfitLastWornUpdates = [];
    for (const doc of eventsSnapshot.docs) {
      const event = doc.data();

      if (event.outfitId) {
        const outfitRef = db.collection("outfits").doc(event.outfitId);
        const outfitDoc = await outfitRef.get();

        if (outfitDoc.exists) {
          const outfit = outfitDoc.data();
          const lastWorn = outfit.lastWorn ? outfit.lastWorn.toDate() : null;
          const eventDatetime = event.eventDatetime.toDate();

          // update only if the event's date is more recent
          if (!lastWorn || eventDatetime > lastWorn) {
            outfitLastWornUpdates.push(
                outfitRef.update({
                  lastWorn: admin.firestore.Timestamp.fromDate(
                      eventDatetime,
                  ),
                }),
            );
          }
        }
      }
    }

    await Promise.all(outfitLastWornUpdates);

    console.log(
        `Successfully updated ${outfitLastWornUpdates.length} outfits.`,
    );
    return null;
  } catch (error) {
    console.error("Error updating outfits:", error);
    throw new functions.https.HttpsError(
        "internal",
        "Failed to update last worn dates.",
    );
  }
});
