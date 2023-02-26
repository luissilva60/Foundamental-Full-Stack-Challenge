from fastapi import APIRouter, Depends
from fullstack_challenge_api.utils.db import get_db
from sqlalchemy.orm import Session

router = APIRouter()


@router.get("/companies")
async def get_companies(db: Session = Depends(get_db)):
    # Query the companies table and return the results
    companies = db.execute('SELECT * FROM companies').fetchall()
    return [
        {
            'id': row[0],
            'date': row[1],
            'funding_amount': row[2],
            'funding_round': row[3].isoformat(),
            'company_id': row[4]
        }
        for row in companies
    ]
