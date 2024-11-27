document.addEventListener("DOMContentLoaded", function () {
    document.querySelectorAll(".like-button").forEach(function (button) {
      button.addEventListener("click", function (event) {
        event.preventDefault(); // ป้องกันการรีเฟรชหน้า
  
        const postId = button.dataset.postId;
        const url = button.dataset.url;
        const method = button.dataset.method;
        const likeSection = document.getElementById(`like-section-${postId}`);
  
        fetch(url, {
          method: method,
          headers: {
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
            "Content-Type": "application/json",
          },
        })
          .then((response) => {
            if (!response.ok) {
              throw new Error("Network response was not ok");
            }
            return response.json();
          })
          .then((data) => {
            // อัปเดตจำนวนไลค์
            likeSection.querySelector(".likes-count").textContent = `${data.likes_count} Likes`;
  
            // อัปเดตปุ่ม
            if (data.liked) {
              button.textContent = "Unlike";
              button.dataset.method = "delete";
              button.classList.remove("like");
              button.classList.add("unlike");
            } else {
              button.textContent = "Like";
              button.dataset.method = "post";
              button.classList.remove("unlike");
              button.classList.add("like");
            }
          })
          .catch((error) => {
            console.error("There was a problem with the fetch operation:", error);
          });
      });
    });
});
  