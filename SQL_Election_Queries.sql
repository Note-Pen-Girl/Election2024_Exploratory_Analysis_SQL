use [India Election Results]
GO

elect * from constituencywise_details;

select * from constituencywise_results;

select * from partywise_results;

select * from states;

select * from statewise_results;

-- Total seats
select 
distinct count(constituency_name) as Total_Seats 
from constituencywise_results;

-- Total No of seats available for election in each state
select s.state,
count(distinct cr.Parliament_Constituency) as Total_seats from states s 
join statewise_results sr on s.state_id=sr.state_id
join constituencywise_results cr on sr.Parliament_Constituency=cr.Parliament_Constituency
group by s.state
order by Total_seats desc;

--Total Seats Won by NDA Allianz
select
sum(case 
    when party in (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
                ) then [won]
    else 0
end) as NDA_alliance_seats_won
from partywise_results;

-- Seats Won by NDA Allianz Parties
select party,
case 
    when party in (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
                ) then [won]
    else 0
end as NDA_alliance_seats_won
from partywise_results
order by NDA_alliance_seats_won desc;

-- total no of seats won by NDA aliiance parties
select party,won from partywise_results where party in  (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
                )
order by won desc;

-- Total Seats Won by I.N.D.I.A. Allianz
SELECT 
    SUM(CASE 
            WHEN party IN (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) THEN [Won]
            ELSE 0 
        END) AS INDIA_Total_Seats_Won
FROM 
    partywise_results;

-- Seats Won by I.N.D.I.A. Allianz Parties
select party,won 
from partywise_results
where party in (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) 
order by won desc;

-- Add new column field in table partywise_results to get the Party Allianz as NDA, I.N.D.I.A and OTHER
alter table partywise_results add allianz_flag varchar(20);
GO

update partywise_results set allianz_flag = 
case
    when party in (
                'Indian National Congress - INC',
                'Aam Aadmi Party - AAAP',
                'All India Trinamool Congress - AITC',
                'Bharat Adivasi Party - BHRTADVSIP',
                'Communist Party of India  (Marxist) - CPI(M)',
                'Communist Party of India  (Marxist-Leninist)  (Liberation) - CPI(ML)(L)',
                'Communist Party of India - CPI',
                'Dravida Munnetra Kazhagam - DMK',
                'Indian Union Muslim League - IUML',
                'Nat`Jammu & Kashmir National Conference - JKN',
                'Jharkhand Mukti Morcha - JMM',
                'Jammu & Kashmir National Conference - JKN',
                'Kerala Congress - KEC',
                'Marumalarchi Dravida Munnetra Kazhagam - MDMK',
                'Nationalist Congress Party Sharadchandra Pawar - NCPSP',
                'Rashtriya Janata Dal - RJD',
                'Rashtriya Loktantrik Party - RLTP',
                'Revolutionary Socialist Party - RSP',
                'Samajwadi Party - SP',
                'Shiv Sena (Uddhav Balasaheb Thackrey) - SHSUBT',
                'Viduthalai Chiruthaigal Katchi - VCK'
            ) then 'I.N.D.I.A'
    when party in (
                'Bharatiya Janata Party - BJP', 
                'Telugu Desam - TDP', 
				'Janata Dal  (United) - JD(U)',
                'Shiv Sena - SHS', 
                'AJSU Party - AJSUP', 
                'Apna Dal (Soneylal) - ADAL', 
                'Asom Gana Parishad - AGP',
                'Hindustani Awam Morcha (Secular) - HAMS', 
                'Janasena Party - JnP', 
				'Janata Dal  (Secular) - JD(S)',
                'Lok Janshakti Party(Ram Vilas) - LJPRV', 
                'Nationalist Congress Party - NCP',
                'Rashtriya Lok Dal - RLD', 
                'Sikkim Krantikari Morcha - SKM'
                ) then 'NDA'
    else 'others'
end;

select * from partywise_results;

-- Which party alliance (NDA, I.N.D.I.A, or OTHER) won the most seats across all states?
select allianz_flag,sum(won) as total_seats
from partywise_results
group by allianz_flag
order by total_seats desc;

-- Winning candidate's name, their party name, total votes, and the margin of victory for a specific state and constituency
select top 10
cr.constituency_name,cr.winning_candidate,cr.total_votes,cr.margin,pr.party,sr.state
from partywise_results pr
join constituencywise_results cr on pr.Party_ID=cr.Party_ID
join statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
order by Total_Votes desc;

-- What is the distribution of EVM votes versus postal votes for candidates in a specific constituency
select 
cd.Candidate,
cd.party,
cd.Total_Votes,
cd.evm_votes,
cd.postal_votes,
cr.constituency_name
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
where cr.Constituency_Name='Madurai'
order by Total_Votes desc;


-- Which parties won the most seats in the State, and how many seats did each party win
select
pr.party,
sr.state,
count(*) as seats_won
from partywise_results pr
join constituencywise_results cr on pr.Party_ID=cr.Party_ID
join statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
group by pr.Party,sr.state
order by seats_won desc;

-- Which candidate received the highest number of EVM votes in each constituency (Top 10)?
-- Top 10 candidates with highest votes (anyone, not necessarily winners)
select top 10
cd.candidate,
cd.evm_votes,
cr.constituency_name
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
order by cd.EVM_Votes desc;

-- Top 10 winning candidates (highest votes among winners) -- correlated subquery
select top 10
cd.candidate,
cd.evm_votes,
cr.constituency_name
from constituencywise_details cd
join constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
where cd.EVM_Votes=(select max(EVM_Votes) from constituencywise_details);

-- noncorrelated subquery using cte
with ranked as(
                select
                cd.candidate,
                cd.evm_votes,
                cr.constituency_name,
                ROW_NUMBER() over(partition by cr.constituency_name order by cd.evm_votes) as row_no
                -- No column name was specified for column 4 of 'ranked', alias name for row_number is must
                from constituencywise_details cd
                join constituencywise_results cr on cd.Constituency_ID=cr.Constituency_ID
                )
select top 10 
Candidate,
EVM_Votes,
Constituency_Name
from ranked
where Constituency_Name='Kannur';

-- Which candidate won and which candidate was the runner-up in each constituency of State for the 2024 elections

select 
sr.leading_candidate as winner,
sr.trailing_candidate as runner,
sr.parliament_constituency,
s.state
from statewise_results sr
join states s on sr.State_ID=s.state_id
where s.State_ID='s05';

-- if not from a direct table
-- not printing voterank gives different o/p

WITH RankedCandidates AS (
    SELECT 
        cd.Constituency_ID,
        cr.Constituency_Name,
        cd.Candidate,
        cr.Total_Votes,
        ROW_NUMBER() OVER (
            PARTITION BY cd.Constituency_ID 
            ORDER BY cr.total_votes DESC
        ) AS VoteRank
    FROM constituencywise_details cd
    JOIN constituencywise_results cr ON cd.Constituency_ID = cr.Constituency_ID
    JOIN statewise_results sr ON cr.Parliament_Constituency = sr.Parliament_Constituency
    JOIN states s ON sr.State_ID = s.State_ID
    WHERE s.State = 'Goa'
)

SELECT 
    Constituency_Name,
    MAX(CASE 
            WHEN VoteRank = 1 THEN Candidate 
            END) AS Winning_Candidate,
    MAX(CASE 
            WHEN VoteRank = 2 THEN Candidate 
            END) AS Runnerup_Candidate,
    VoteRank
FROM RankedCandidates
GROUP BY Constituency_Name,VoteRank
ORDER BY Constituency_Name;

-- For the state of Delhi, what are the total number of seats, total number of candidates, 
-- total number of parties, total votes (including EVM and postal), and the breakdown of EVM and postal votes
select
s.state,
count(distinct sr.constituency) as Total_constituencies,
count(distinct cd.candidate) as Total_candidates,
count(distinct pr.party) as Total_parties,
sum(cd.evm_votes) as Total_evm_votes,
sum(cd.postal_votes) as Total_postal_votes,
sum(cd.total_votes) as Total_votes
from constituencywise_results cr
join constituencywise_details cd on cr.Constituency_ID=cd.Constituency_ID
join partywise_results pr on cr.Party_ID=pr.Party_ID
join statewise_results sr on cr.Parliament_Constituency=sr.Parliament_Constituency
join states s on sr.State_ID=s.State_ID
where s.state='Delhi'
group by s.state;

