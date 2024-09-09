1. The user has to start maven server to point run backend. 
2. In the any browser user has to go to localhost:8080 
3. The page offer some requared fields (id, userId, title, body) and operative buttons (get contribution by Id or userId, delete, update title and body)
4. Id (Integer) represents the id for contribution, userId (Integer) the ID for the user, title is a title for contribution and body is contribution itself.
5. The user can use the 5 buttons for operations. To get any contribution by Id or userId can use "Get by Id" or "Get by User Id". If the user wants to make another contribution the user has to fill all field with unique Id. To edit its opposite situation and the contribution It has to be found. For delete is necessary to delete existing contribution. 
6. The button "Get by Id" is special case. If the database doesnt contain the contribution by given Id, the whole contribution is taken from external API.
