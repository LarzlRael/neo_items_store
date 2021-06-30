const { Router } = require("express");

const router = Router();

router.get('/', (req, res) => {
    res.send('hi :D')
})

module.exports = router;