from fastapi import APIRouter, Depends
from fullstack_challenge_api.utils.db import get_db
from sqlalchemy.orm import Session

router = APIRouter()


@router.get("/deals")
async def get_deals(db: Session = Depends(get_db)):
    # Query the deals table and return the results
    deals = db.execute('SELECT * FROM deals').fetchall()
    return [
        {
            'id': row[0],
            'name': row[1],
            'country': row[2],
            'founding_date': row[3],
            'description': row[4],
            'company_id': row[5]
        }
        for row in deals
    ]
