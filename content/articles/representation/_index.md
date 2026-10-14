+++
date = '2026-10-10T08:15:55-04:00'
title = 'Representation'
description = 'Potential improvements to US representative democracy'
categories = ['public-policy']
tags = ['constitution','voting','politics']
layout = "single"
draft = true
+++

The United States political system gives the people already in office
considerable control over who can replace them. They write the
election rules, and in most cases the party in power draws the
electoral districts. Money is needed to run political campaigns
(see [money in politics](../money-in-politics/)), most prominently to market
the candidate and his or her positions. For many reasons, the incumbent has advantages in raising
money and generating free publicity. We then act surprised when the
resulting legislature is difficult to dislodge. Senator Chuck Grassley
(R-IA) has been in office since 1981.  Senator Mitch McConnell (R-KY)
has been in office since 1985. Representatives Hal Rogers (R-KY) and
Chris Smith (R-NJ) have been in office since 1981. While the oldest,
these are [not
outliers](https://en.wikipedia.org/wiki/List_of_longest-serving_members_of_the_United_States_Congress). A
[quick analysis]({{< relref "congress-analysis" >}}) of 2014 to 2024 found
members were about twice as likely to leave on their own terms or die as to
be voted out.

Gerrymandering is the most obvious abuse, but the problem goes beyond
manipulated maps. Even an honestly drawn set of districts can leave a
large number of people with little political representation. We
award one seat to one winner, then discard everyone else's preferences
when allocating seats.

I think a better system is to elect the House through ranked choice
voting in districts with several representatives, using a proportional
counting method. That needs to be combined with independent
redistricting. More voters would then be able to elect representatives
who share their views, and the party drawing a boundary would have
less power to determine the result.

## Where We Started

The Constitution was a compromise among former colonies trying to form
a workable government. Large states wanted representation based on
population. Small states wanted equal standing. The resulting Congress
defined by the US Constitution has a House apportioned by population
and a Senate with two members from each state.[^compromise]

That arrangement helped secure agreement in 1787. It is arguably not
the best arrangement now, if ever. Some of the bargains were
indefensible even then, notably the three-fifths clause which
increased slaveholding states' representation by counting people those
states enslaved but denied any political voice.[^constitution] The
founders negotiated a government they could get adopted. They did not
finish the work of designing representative democracy, nor did they
believe they had.

The Electoral College incorporated the states' House seats and their
equal Senate representation into presidential selection. Organized
parties soon exposed problems with the original procedure, requiring
the Twelfth Amendment. Most states now award all their electors to the
statewide winner, although the Constitution does not require that
winner-take-all practice.[^electors][^amendments]

The Constitution did not require two parties either. Our election
rules have helped make two parties the practical limit, giving each a
broad coalition of voters who often agree on little except that they
dislike the other party more. Too often this dislike of the "other"
doesn't even react to changes in the "other" party's positions when
they change.

Manipulating districts came early. Gerrymandering takes its name from
a Massachusetts districting law signed by Elbridge Gerry in
1812.[^gerry] Its appeal has not changed: arrange the voters so that
your side wins more seats without needing more votes. The modern
version has far better tools, but the conflict of interest remains the
same.

We have changed the constitutional system repeatedly when its
limitations became unacceptable. Its age is an explanation for some of
its problems, not a reason to perpetuate them.

## Where We Are

### The maps are often misleading

A county map colored red or blue makes a sparsely populated area look
politically enormous. A city may contain more voters while occupying a
small patch of the picture. Giving the entire county its winner's
color also makes the losing voters disappear.

World Mapper maps of recent elections show how much the picture
changes when geography is resized by population.[^maps] They are worth
comparing before using a mostly red or mostly blue map as evidence of
what Americans want.

![Hypothetical regions: one has 80 percent of the land but 20 percent
 of the voters; the other has 20 percent of the land and 80 percent of
 the voters.](land-and-voters.svg)

*An illustration of the difference between land area and voters, using
hypothetical numbers.*

### A fair-looking map can still produce a poor result

Suppose five equally populated districts each vote sixty percent for
Party A and forty percent for Party B. Party A wins all five
seats. Party B's voters are two-fifths of the electorate and elect
none of their candidates.

No gerrymander was necessary. Single-member districts produced that
result by awarding every seat to a local majority. Research on
political geography explains why better boundaries alone cannot
reliably produce proportional representation.[^geography]

Gerrymandering makes this weakness useful to the people drawing the
map. They can *pack* opposing voters into a few districts won by huge
margins and *crack* the remainder among districts where they cannot
win. Equal population does not prevent either technique.

![The same 60 A voters and 40 B voters in five equal districts can
 produce three A and two B seats, or four A and one B seats, depending
 on the grouping.](packing-and-cracking.svg)

*The arithmetic of packing and cracking. These groups are a schematic,
 not a proposed geographic map.*

An independent commission can remove the most direct conflict of
interest. It cannot give a single district more than one winner. I
support commissions, but stopping there would leave much of the
problem in place.

### Two parties, often one meaningful contest

Under first-past-the-post, a candidate can win with forty percent when
the other sixty percent is divided between opponents. That gives
voters a reason to abandon their preferred candidate if that candidate
appears unlikely to win. Vote for someone you do not particularly
like, or risk helping someone you like even less.

The two major parties benefit from that calculation. A new party has
to persuade people to support it and persuade them that supporting it
will not be self-defeating. That is a substantial barrier before
questions of money and ballot access even arise.

Gerrymandering can narrow the choice further. In a safe district, the
dominant party's primary may effectively choose the
representative. The general election then ratifies a decision made by
a much smaller group. A member still has a duty to serve every
constituent, but many constituents have little practical ability to
replace that member with someone closer to their views.

Telling those people to vote harder is an inadequate response. We need
rules under which their votes can elect somebody.

Because of its design to emphasize state representation, the Senate's
imbalance has become extreme. California had about 68.5
times Wyoming's resident population in the 2020 Census. Both states
had two senators.[^population] This is not even the representation
difference apparent at the signing of the Constitution.

#### Minimum and maximum constituents per senator

| Comparison           | Founding-era states (1790) | Current states (2025) |
| -------------------- | -------------------------- | --------------------- |
| Least-populous state | Delaware                   | Wyoming               |
| State population     | 59,094                     | 588,753               |
| People per senator   | 29,547                     | 294,377               |
| Most-populous state  | Virginia                   | California            |
| State population     | 747,610                    | 39,355,309            |
| People per senator   | 373,805                    | 19,677,655            |

Sources: official 1790 census tables[^census1790] and Census Bureau
2025 estimates[^census2025].

That means Wyoming's average population per senator is about ten times
Delaware's in 1790.  California's average population per senator is
about 53 times Virginia's in 1790.  The national average rose from
about 151,000 people per senator to 3.42 million, roughly 23 times as many.

The key change is not simply that each senator represents more
people. It is that the disparity between states has grown
dramatically.
- In 1790, the most-populous state's senator represented about 12.7
  times as many people as the least-populous state's senator.
- In 2025, that ratio was about 66.8 to one.

Defenders say this protects small states from large ones. It does so
by giving the residents of those states very different amounts of
representation. While small-state residents deserve enforceable rights
and a voice in government and large states should not be able to
simply impose their will on small states. They do not need vastly
greater representation per person to have either. Constitutional
rights should protect people from an abusive majority wherever they
live; weighting representation by state boundaries is a poor
substitute.

## Alternatives in other countries and some states

Changing the form of government would not automatically fix this. The
United Kingdom has a constitutional monarchy and parliamentary
government, but its House of Commons is elected through single-member
plurality contests.[^uk] Importing a parliamentary system while
retaining that method would preserve the same basic opportunity to
turn a modest voting advantage into a much larger seat advantage.

New Zealand's mixed-member proportional system addresses the
allocation of seats more directly. Voters choose a local candidate and
a party. List seats compensate for constituency results so that the
party vote largely determines each qualifying party's total
representation.[^nz] Winning extra districts through favorable
boundaries therefore offers much less leverage over the final balance.

That would be a substantial improvement over our system. I prefer
Ireland's approach for the House: multi-member constituencies using
the single transferable vote, or STV. Voters rank individual
candidates and can cross party lines or choose among candidates within
a party.[^ireland] It offers proportional representation while leaving
the choice of representatives more directly with voters, without a
separate tier of party-list seats.

The tradeoff is that STV does not promise an exact statewide match
between party vote shares and seats. District size and transfers
affect the outcome. I would accept that in exchange for candidate
choice and geographic representation, particularly because it would
still greatly improve the opportunity for substantial minorities to
elect someone.

More parties could mean more legislative bargaining. Our two parties
already contain factions that bargain,[^caucuses] threaten to
withhold support, and disagree about policy. I would rather give
voters a clearer choice among those positions than require them to buy
an entire party package and hope the internal negotiations go their
way.

Alaska is an example of an open primary state[^alaska], a policy that
should become universal. It substantially cuts down the power of tiny
minorities voting in party exclusive primaries.

## The solutions, or at least improvements, are known

Ranked choice by itself is insufficient. In a single-seat contest it
lets voters identify fallbacks, reducing the pressure to abandon a
first choice immediately. The district still has one winner. Its
boundaries can still make the decisive difference.

For the House, I would combine **ranked ballots, several seats per
district, proportional counting, and open primaries**. Each voter has one transferable
vote. Candidates reaching a quota are elected; surplus votes or voting
weight move to subsequent preferences. When necessary, the lowest
candidate is eliminated and those votes transfer. Counting continues
until the seats are filled.[^ireland][^aec]

In a five-seat district, the usual quota is just over one-sixth of
valid votes. A group need not become a local majority before it can
elect a representative. That is the change that matters for both
representation and gerrymandering.

![A 60–40 electorate produces five A representatives in five identical
 single-member districts, compared with three A and two B
 representatives in a five-seat proportional district under the stated
 assumptions.](votes-and-seats.svg)

*Illustration assumes enough candidates and voters ranking their
 party's candidates first. Actual results depend on rankings and
 transfers.*

Simply creating five seats and letting everyone vote for five
candidates would not accomplish this. An organized majority could
sweep all five. Multi-member districts need the proportional method;
otherwise we risk enlarging the district while preserving the
exclusion.

Research modeling U.S. House elections finds that multi-member STV
districts substantially limit the advantage available through partisan
gerrymandering.[^research] Independent commissions would then be
working with an electoral method less vulnerable to boundary
manipulation, rather than trying to compensate for its basic design.

I would generally favor districts with three to five members, adjusted
to each state's delegation. Boundaries and district size would still
need scrutiny for their effects on racial and language minorities and
communities of interest. A reform should make it easier for those
voters to elect candidates, not hide dilution inside a larger
district.

The objection about losing a single local representative is less
persuasive when that representative can safely disregard a large part
of the electorate. Several representatives would give a constituent
more people to approach and a better chance of finding one sympathetic
to the problem. Larger rural districts would need properly funded
local offices so that this does not become an excuse to make
representatives physically inaccessible.

The count would be more complicated. That calls for clear transfer
rules, paper records, published results, and appropriate audits. It is
a solvable election-administration problem, with functioning examples
abroad. Keeping a simpler count is a poor bargain if it keeps
producing a less representative legislature.

### We can start without amending the Constitution

The single-member requirement for House elections is statutory: 2
U.S.C. § 2c. Congress can change it under its authority over
congressional election rules.[^districtlaw][^elections] The Fair
Representation Act introduced in 2024 is an example of legislation
combining ranked choice, multi-member districts, and redistricting
reform.[^fra]

House seats would still be apportioned among states, so districts
would remain within state boundaries. A state with one House seat
would still elect one representative. We should also increase the
House beyond 435 members, another number established by law, to
improve constituent access and make multi-member districts possible in
more states.[^housesize] A 600 member house is large to be sure, but
"only" a 40% increase. Using the 2020 census apportionment populations,
the Huntington-Hill method, and a minimum of two seats per state, California
would get the most seats (71) and Wyoming would have the smallest districts
(about 289,000 people). The national average would be about 552,000 per
district. That compares with roughly 786,000 per district today, using the
Census Bureau's 2025 population estimate spread over 435 seats. (The current
districts were drawn for about 761,000 people after the 2020 census and have
grown since.) Forty states land between about 515,000 and 615,000 people per
district. The two-seat minimum pushes the smallest states below that range:
Wyoming is lowest, then Vermont (323,000), Alaska (368,000) and North Dakota
(390,000). Idaho has the largest districts at about 614,000. Eight states sit
at the 2-seat floor: AK, DE, MT, ND, RI, SD, VT, and WY.

Replacing the Electoral College with a direct national vote requires
constitutional change. Altering equal state representation in the
Senate faces Article V's additional protection of each state's equal
suffrage without its consent.[^constitution][^articlev] Those are
harder changes, and both run through a Court whose
[appointment and ethics rules](../supreme-court/) I would also change. They should not hold the House reform hostage.  Open
primaries also require no constitutional change and would immediately
have an effect on Senate elections.

The immediate proposal is practical: change the federal districting
law, establish proportional ranked choice elections, and take
mapmaking out of the hands of the legislators who benefit from
it. Fund the transition and make the count auditable.

The people benefiting from safe seats and limited competition have
little reason to volunteer for this. That explains much of the
resistance. It does **not** make their preferred rules appropriate for
the rest of us.

The same insiders-write-the-rules problem shows up elsewhere. Campaign
spending is covered in [money in politics](../money-in-politics/), the
Supreme Court's appointment and ethics rules in [the Supreme
Court](../supreme-court/), and the economic version of it in [economic
policy](../economic-policy/). Healthcare is a good test case of why a
legislature that answers to voters matters: the [healthcare
article](../healthcare/) describes a solution that is well known and
still blocked.

## References

[^compromise]: U.S. Senate Historical Office, [A Great Compromise](https://www.senate.gov/about/origins-foundations/senate-and-constitution/great-compromise.htm).
[^constitution]: National Archives, [The Constitution of the United States: A Transcription](https://www.archives.gov/founding-docs/constitution-transcript), especially Article I, Sections 2–4, and Article II.
[^electors]: National Archives, [Electoral College History](https://www.archives.gov/electoral-college/history).
[^amendments]: National Archives, [The Constitution: Amendments 11–27](https://www.archives.gov/founding-docs/amendments-11-27), especially Amendments XII, XIV, XV, XVII, XIX, XXIV, and XXVI.
[^gerry]: Neely Tucker, Library of Congress, [Gerrymandering: The Origin Story](https://blogs.loc.gov/loc/2024/07/gerrymandering-the-origin-story/), July 18, 2024.
[^maps]: World Mapper, [Cartograms of the 2024 Election Results](https://worldmapper.org/maps/us-presidential-election-2024-results/), These show a historical election, not present-day party support.
[^population]: U.S. Census Bureau, [2020 Census Apportionment Results Delivered to the President](https://www.census.gov/newsroom/press-releases/2021/2020-census-apportionment-results.html), April 26, 2021. Comparison uses resident population: California 39,538,223; Wyoming 576,851.
[^census1790]: U.S. Census Bureau. 1790 Census: Population of the United States. Historical census records and state population tables. https://www.census.gov/history/www/through_the_decades/overview/1790.html
[^census2025]: U.S. Census Bureau. State Population Totals and Components of Change: 2020–2025. State population estimates. https://www.census.gov/data/tables/time-series/demo/popest/2020s-state-total.html
[^geography]: Moon Duchin and Gabe Schoenbach, [Redistricting for Proportionality](https://arxiv.org/abs/2308.11529), research paper, 2023.
[^uk]: UK Parliament, [Parliament and Crown](https://www.parliament.uk/about/how/role/relations-with-other-institutions/parliament-crown/); House of Commons Library, [Voting Systems in the UK](https://commonslibrary.parliament.uk/research-briefings/sn04458/).
[^nz]: Elections New Zealand, [What Is MMP?](https://elections.nz/democracy-in-nz/what-is-new-zealands-system-of-government/what-is-mmp).
[^ireland]: Ireland's Electoral Commission, [Ireland's Voting System](https://www.electoralcommission.ie/irelands-voting-system/).
[^aec]: Australian Electoral Commission, [How the Senate Result Is Determined](https://www.aec.gov.au/voting/counting/senate_count.htm). This documents one specific STV implementation, including quota, surplus transfers, and exhausted ballots.
[^caucuses]: Unite America [Who Really Elected the Freedom Caucus and The Squad? Hardly Anyone](https://www.uniteamerica.org/articles/who-really-elected-the-freedom-caucus-and-the-squad-hardly-anyone)
[^alaska]: Unite America [Alaska’s Election System Blunts Political Gamesmanship](https://www.uniteamerica.org/articles/alaskas-election-system-blunts-political-gamesmanship)
[^research]: Nikhil Garg, Wes Gurnee, David Rothschild, and David Shmoys, [Combatting Gerrymandering with Ranked Choice Voting: An Experimental Analysis of Multi-member Districts in the United States](https://arxiv.org/abs/2107.07083). Research first posted in 2021; the linked record includes revisions.
[^districtlaw]: [2 U.S.C. § 2c](https://www.law.cornell.edu/uscode/text/2/2c), the statutory single-member district requirement.
[^elections]: Library of Congress, Constitution Annotated, [Congress and the Elections Clause](https://constitution.congress.gov/browse/essay/artI-S4-C1-3/ALDE_00013640/).
[^fra]: U.S. Government Publishing Office, [H.R. 7740, Fair Representation Act, introduced March 20, 2024](https://www.govinfo.gov/content/pkg/BILLS-118hr7740ih/html/BILLS-118hr7740ih.htm), 118th Congress. Proposed legislation, cited as an example rather than as current law.
[^housesize]: U.S. House of Representatives, History, Art & Archives, [Determining Apportionment](https://history.house.gov/Institution/Apportionment/Determining-Apportionment/).
[^articlev]: Library of Congress, Constitution Annotated, [Unamendable Subjects](https://constitution.congress.gov/browse/essay/artV-5/ALDE_00013059/), discussing Article V's equal-suffrage provision.
