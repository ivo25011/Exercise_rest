<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Contributions</title>
    <style>
        .input-box {
            padding: 5px;
            margin-bottom: 10px;
        }
        .button-box {
            padding: 5px;
            margin-right: 5px;
            display: inline-block;
        }
        .result-box {
            border: 1px solid black;
            margin-top: 20px;
            padding: 10px;
        }
    </style>
</head>
<body>
    <form id="contributionForm" onsubmit="return false;">
    <!-- Fields -->
        <div class="input-box">
             <label for="id">ID:</label>
             <input type="text" id="id" name="id" />
        </div>
        <div class="input-box">
             <label for="userId">User ID:</label>
             <input type="text" id="userId" name="userId" />
        </div>
        <div class="input-box">
             <label for="title">Title:</label>
             <input type="text" id="title" name="title" />
        </div>
        <div class="input-box">
             <label for="body">Body:</label>
             <textarea id="body" name="body" rows="5" cols="50"></textarea>
        </div>

    <!-- Buttons -->
        <div class="button-box">
            <button type="button" onclick="getContributionById()">Get by ID</button>
        </div>
        <div class="button-box">
            <button type="button" onclick="getContributionByUserId()">Get by User ID</button>
        </div>
        <div class="button-box">
            <button type="button" onclick="addContribution()">Add</button>
        </div>
        <div class="button-box">
            <button type="button" onclick="deleteContribution()">Delete</button>
        </div>
        <div class="button-box">
            <button type="button" onclick="editContribution()">Edit</button>
        </div>
    </form>

    <!-- The results will be show here -->
    <div id="show" class="result-box"></div>

    <script>
    <!-- Script getContributionById() for check input values, fetch REST api and show result -->
        function getContributionById() {
            const id = document.getElementById('id').value;
            console.log("Requested ID:", id);

            if (!id) {
                alert("Please enter an ID");
                return;
            }

            fetch("contributions/".concat(id))
                .then(response => {
                    console.log("Response status:", response.status); // Log response to console
                    if (!response.ok) {
                        throw new Error('Contribution not found');
                    }
                    return response.json();
                })
                .then(data => {
                    console.log("Data received:", data); // Log data to console
                    // Zobrazenie údajov v div-e "show"
                    document.getElementById('show').innerHTML = `
                        <p><strong>ID:</strong> ${data['id']}</p>
                        <p><strong>User ID:</strong> ${data['userId']}</p>
                        <p><strong>Title:</strong> ${data['title']}</p>
                        <p><strong>Body:</strong> ${data['body']}</p>
                    `;
                })
                .catch(error => {
                    console.log("Error encountered:", error.message); // Zaloguj chybu
                    document.getElementById('show').innerHTML = `<p>Error ${error.message}</p>`;
                });
        }

        <!-- Script getContributionByUserId() for check input values, fetch REST api and show result -->
        function getContributionByUserId() {
                    const id = document.getElementById('userId').value;

                    console.log("Requested ID:", id);

                    if (!id) {
                        alert("Please enter an user ID");
                        return;
                    }

                    fetch("contributions/user/".concat(id))
                        .then(response => {
                            console.log("Response status:", response.status); // // Log response to console
                            if (!response.ok) {
                                throw new Error('Contribution not found');
                            }
                            return response.json();
                        })
                        .then(data => {
                            console.log("Data received:", data); // Log data to console
                            // Zobrazenie údajov v div-e "show"
                            document.getElementById('show').innerHTML = `
                                <p><strong>ID:</strong> ${data['id']}</p>
                                <p><strong>User ID:</strong> ${data['userId']}</p>
                                <p><strong>Title:</strong> ${data['title']}</p>
                                <p><strong>Body:</strong> ${data['body']}</p>
                            `;
                        })
                        .catch(error => {
                            console.log("Error encountered:", error.message);
                            document.getElementById('show').innerHTML = `<p>Error ${error.message}</p>`;
                        });
                }

        <!-- Script addContribution() for check input values, fetch REST api and show result -->
        function addContribution() {
                    // Get values from form fields
                			const id = document.getElementById('id').value;
                			const userId = document.getElementById('userId').value;
                			const title = document.getElementById('title').value;
                			const body = document.getElementById('body').value;

                    if (!id && !userId && !title && !body) {
                        alert("Please enter an values");
                        return;
                    }

                    // Create the contribution object
                    const contribution = {
                		id:id,
                		userId:userId,
                        title: title,
                        body: body
                    };

                console.log(contribution);
                    // Send POST request to the controller
                    fetch('/contributions/add', {
                        method: 'POST',
                        headers: {
                            'Content-Type': 'application/json',
                        },
                        body: JSON.stringify(contribution)
                    })
                    .then(response => {
                        if (response.ok) {
                            console.log('Contribution added successfully'); // Log response to console
                        } else {
                            console.error('Failed to add contribution');

                        }
                    })
                    .catch(error => {
                        console.error('Error:', error);
                        // Handle network errors
                    });
        }

        <!-- Script deleteContribution() for check input values, fetch REST api and show result -->
        function deleteContribution() {
                    const id = document.getElementById('id').value;
                    console.log("Requested ID:", id); // Zaloguj hodnotu ID pre istotu
                    if (!id) {
                        alert("Please enter an ID");
                        return;
                    }

                    console.log("/contributions/delete/".concat(id));
                    fetch("contributions/delete/".concat(id), {
                        method: 'DELETE'
                    }).then(response => {
                    console.log("Response status:", response.status); // Log response to console
                        if (response.ok) {
                            console.log('Contribution deleted successfully');
                        } else {
                            console.log('Error deleting contribution');
                        }
                    });
                }

        <!-- Script editContribution() for check input values, fetch REST api and show result -->
        function editContribution() {
                            // Get values from form fields
                        			const id = document.getElementById('id').value;
                        			const userId = document.getElementById('userId').value;
                        			const title = document.getElementById('title').value;
                        			const body = document.getElementById('body').value;

                            // Create the contribution object
                            const contribution = {
                        		id:id,
                        		userId:userId,
                                title: title,
                                body: body
                            };

                            if (!id) {
                               alert("Please enter an ID");
                              return;
                            }

                        console.log(contribution);
                            // Send PUT request to the controller
                            fetch('/contributions/update', {
                                method: 'PUT',
                                headers: {
                                    'Content-Type': 'application/json',
                                },
                                body: JSON.stringify(contribution)
                            })
                            .then(response => {
                                if (response.ok) {
                                    console.log('Contribution edited successfully');
                                } else {
                                    console.error('Failed to edit contribution');
                                }
                            })
                            .catch(error => {
                                console.error('Error:', error);
                                // Handle network errors
                            });
                }
    </script>
</body>
</html>
