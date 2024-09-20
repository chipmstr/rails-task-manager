document.addEventListener("DOMContentLoaded", function() {
  // find all delete buttons with the class 'delete-task'
  const deleteLinks = document.querySelectorAll(".delete-task");

  // iterate over each delete link
  deleteLinks.forEach(link => {
    // add a click event listener to each delete button
    link.addEventListener("click", function(event) {
      event.preventDefault();  // prevents default behavior (page reload or link navigation)

      // retrieve the task id from the 'data-id' attribute
      const taskId = this.getAttribute("data-id");

      // confirm deletion with the user
      if (confirm("Are you sure?")) {
        // send a DELETE request using the fetch API
        fetch(`/tasks/${taskId}`, {
          method: "DELETE",  // specify DELETE request
          headers: {
            // include CSRF token for Rails security
            "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
            "Content-Type": "application/json"
          }
        })
        .then(response => {
          // if the response is successful, redirect to the tasks list
          if (response.ok) {
            window.location.href = "/tasks";
          } else {
            // alert if there is an issue deleting the task
            alert("Failed to delete the task.");
          }
        })
        .catch(error => console.error("Error:", error));  // log any errors
      }
    });
  });
});
