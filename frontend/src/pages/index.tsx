import { useEffect, useState } from 'react';

const Home = () => {
  const [companies, setCompanies] = useState([]);
  const [deals, setDeals] = useState([]);

  useEffect(() => {
    async function fetchData() {
      const companiesResponse = await fetch('http://localhost:20002/companies');
      const companiesData = await companiesResponse.json();
      setCompanies(companiesData);

      const dealsResponse = await fetch('http://localhost:20002/deals');
      const dealsData = await dealsResponse.json();
      setDeals(dealsData);
    }

    fetchData();
  }, []);

  return (
      <div>
        <h1>Companies</h1>
        <table>
          <thead>
          <tr>
            <th>Name</th>
            <th>Country</th>
            <th>Founding Date</th>
            <th>Description</th>

          </tr>
          </thead>
          <tbody>
          {companies.map((company) => (
              <tr key={company.id}>
                <td>{company.name}</td>
                <td>{company.country}</td>
                <td>{company.founding_date}</td>
                <td>{company.description}</td>
              </tr>
          ))}
          </tbody>
        </table>

        <h1>Deals</h1>
        <table>
          <thead>
          <tr>
            <th>Date</th>
            <th>Funding Amount</th>
            <th>Funding Round</th>
            <th>Company ID</th>
          </tr>
          </thead>
          <tbody>
          {deals.map((deal) => (
              <tr key={deal.id}>
                <td>{deal.date}</td>
                <td>{deal.funding_amount}</td>
                <td>{deal.funding_round}</td>
                <td>{deal.company_id}</td>
              </tr>
          ))}
          </tbody>
        </table>
      </div>
  );
};

export default Home;
