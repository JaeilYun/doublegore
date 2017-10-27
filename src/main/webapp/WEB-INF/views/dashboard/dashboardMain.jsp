<%@ page language="java" contentType="text/html; charset=UTF-8"   pageEncoding="UTF-8" session="true" %>

<div class="content">
	<div class="main-header">
		<h2>DASHBOARD v4</h2>
		<em>investment portfolio and market info</em>
	</div>
	<div class="main-content">
		<div class="row bottom-60px">
			<div class="col-md-2">
				<div class="investment-summary">
					<span class="info-label">Current Value</span>
					<strong>$67,300</strong>
				</div>
			</div>
			<div class="col-md-2">
				<div class="investment-summary">
					<span class="info-label">Total Invested</span>
					<strong>$50,000</strong>
				</div>
			</div>
			<div class="col-md-2 col-md-offset-2">
				<div class="investment-summary text-right">
					<span class="info-label">Today's Gain/Loss</span>
					<span class="inv-red"><strong>$147.85</strong> <i class="fa fa-caret-down"></i></span> <span class="percentage">0.43%</span>
				</div>
			</div>
			<div class="col-md-2">
				<div class="investment-summary text-right">
					<span class="info-label">Month’s Gain/Loss</span>
					<span class="inv-green"><strong>$1846.56</strong> <i class="fa fa-caret-up"></i></span> <span class="percentage">3.87%</span>
				</div>
			</div>
			<div class="col-md-2">
				<div class="investment-summary text-right">
					<span class="info-label">YTD’s Gain/Loss</span>
					<span class="inv-green"><strong>$17,300.00</strong> <i class="fa fa-caret-up"></i></span> <span class="percentage">15.53%</span>
				</div>
			</div>
		</div>
		<div class="row bottom-60px">
			<div class="col-md-8">
				<table class="table table-striped">
					<thead>
					<tr>
						<th>Asset Type</th>
						<th>Current Valuation</th>
						<th>Amount Invested</th>
						<th>Today's G/L</th>
						<th>Month's G/L</th>
						<th>YTD's G/L</th>
					</tr>
					</thead>
					<tbody>
					<tr>
						<td><a href="#">Stock</a></td>
						<td>$23,000</td>
						<td>$18,000</td>
						<td><span class="inv-red">0.34%</span></td>
						<td><span class="inv-green">4.56%</span></td>
						<td><span class="inv-green">18.28%</span></td>
					</tr>
					<tr>
						<td><a href="#">Mutual Fund</a></td>
						<td>$2,300</td>
						<td>$2,000</td>
						<td><span class="inv-red">1.64%</span></td>
						<td><span class="inv-red">5.66%</span></td>
						<td><span class="inv-green">12.09%</span></td>
					</tr>
					<tr>
						<td><a href="#">Fixed Assets</a></td>
						<td>$35,000</td>
						<td>$20,000</td>
						<td><span class="inv-red">8.54%</span></td>
						<td><span class="inv-red">12.78%</span></td>
						<td><span class="inv-green">25.32%</span></td>
					</tr>
					<tr>
						<td><a href="#">Foreign Exchange</a></td>
						<td>$6,000</td>
						<td>$7,500</td>
						<td><span class="inv-green">12.88%</span></td>
						<td><span class="inv-red">17.85%</span></td>
						<td><span class="inv-red">30.28%</span></td>
					</tr>
					<tr>
						<td><a href="#">Others</a></td>
						<td>$1,000</td>
						<td>$2,500</td>
						<td><span class="inv-red">15.50%</span></td>
						<td><span class="inv-red">27.33%</span></td>
						<td><span class="inv-red">35.21%</span></td>
					</tr>
					<tr>
						<td><a href="#">Stock</a></td>
						<td>$23,000</td>
						<td>$18,000</td>
						<td><span class="inv-red">0.34%</span></td>
						<td><span class="inv-green">4.56%</span></td>
						<td><span class="inv-green">18.28%</span></td>
					</tr>
					<tr>
						<td><a href="#">Mutual Fund</a></td>
						<td>$2,300</td>
						<td>$2,000</td>
						<td><span class="inv-red">1.64%</span></td>
						<td><span class="inv-red">5.66%</span></td>
						<td><span class="inv-green">12.09%</span></td>
					</tr>
					</tbody>
				</table>
			</div>
			<div class="col-md-4">
				<div id="investment-donut-chart"></div>
			</div>
		</div>
		<div class="row bottom-60px">
			<div class="col-md-3">
				<div class="stock-info">
					<span class="company">Apple Inc.</span>
					<span class="value inv-red">93.40</span>
					<span class="change"><i class="fa fa-caret-down inv-red"></i> 2.81%</span>
				</div>
			</div>
			<div class="col-md-3">
				<div class="stock-info">
					<span class="company">Microsoft Corporation</span>
					<span class="value inv-red">49.83</span>
					<span class="change"><i class="fa fa-caret-down inv-red"></i> 4.01%</span>
				</div>
			</div>
			<div class="col-md-3">
				<div class="stock-info">
					<span class="company">Ford Motor Co.</span>
					<span class="value inv-green">49.83</span>
					<span class="change"><i class="fa fa-caret-up inv-green"></i> 4.01%</span>
				</div>
			</div>
			<div class="col-md-3">
				<div class="stock-info">
					<span class="company">AT&amp;T, Inc.</span>
					<span class="value inv-green">41.52</span>
					<span class="change"><i class="fa fa-caret-up inv-green"></i> 0.86%</span>
				</div>
			</div>
		</div>
		<div class="row bottom-30px">
			<div class="col-md-8">
				<ul class="nav nav-pills nav-pills-custom-minimal custom-minimal-bottom" role="tablist">
					<li class="active"><a href="#actives" role="tab" data-toggle="tab"><i class="fa fa-flash"></i> Most Actives</a></li>
					<li><a href="#gainers" role="tab" data-toggle="tab"><i class="fa fa-level-up"></i> Gainers</a></li>
					<li><a href="#losers" role="tab" data-toggle="tab"><i class="fa fa-level-down"></i> Losers</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade in active" id="actives">
						<table class="table table-striped">
							<thead>
							<tr>
								<th>Symbol</th>
								<th>Company Name</th>
								<th>Price</th>
								<th>Change</th>
								<th>% Change</th>
								<th>Volume</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>BAC</td>
								<td>Bank of America Corporation</td>
								<td>13.04</td>
								<td><span class="inv-red">-1.04</span></td>
								<td><span class="inv-red">-7.41%</span></td>
								<td>239,499,186</td>
							</tr>
							<tr>
								<td>MSFT</td>
								<td>Microsoft Corporation</td>
								<td>49.83</td>
								<td><span class="inv-green">+2.08</span></td>
								<td><span class="inv-green">+4.01%</span></td>
								<td>133,502,263</td>
							</tr>
							<tr>
								<td>AAPL</td>
								<td>Apple Inc.</td>
								<td>93.40</td>
								<td><span class="inv-green">+2.70</span></td>
								<td><span class="inv-green">+2.81%</span></td>
								<td>75,311,762</td>
							</tr>
							<tr>
								<td>BAC</td>
								<td>Bank of America Corporation</td>
								<td>13.04</td>
								<td><span class="inv-red">-1.04</span></td>
								<td><span class="inv-red">-7.41%</span></td>
								<td>239,499,186</td>
							</tr>
							<tr>
								<td>MSFT</td>
								<td>Microsoft Corporation</td>
								<td>49.83</td>
								<td><span class="inv-green">+2.08</span></td>
								<td><span class="inv-green">+4.01%</span></td>
								<td>133,502,263</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="gainers">
						<table class="table table-striped">
							<thead>
							<tr>
								<th>Symbol</th>
								<th>Company Name</th>
								<th>Price</th>
								<th>Change</th>
								<th>% Change</th>
								<th>Volume</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>AAPL</td>
								<td>Apple Inc.</td>
								<td>93.40</td>
								<td><span class="inv-green">+2.70</span></td>
								<td><span class="inv-green">+2.81%</span></td>
								<td>75,311,762</td>
							</tr>
							<tr>
								<td>MSFT</td>
								<td>Microsoft Corporation</td>
								<td>49.83</td>
								<td><span class="inv-green">+2.08</span></td>
								<td><span class="inv-green">+4.01%</span></td>
								<td>133,502,263</td>
							</tr>
							<tr>
								<td>BAC</td>
								<td>Bank of America Corporation</td>
								<td>13.04</td>
								<td><span class="inv-green">+1.04</span></td>
								<td><span class="inv-green">+7.41%</span></td>
								<td>239,499,186</td>
							</tr>
							<tr>
								<td>AAPL</td>
								<td>Apple Inc.</td>
								<td>93.40</td>
								<td><span class="inv-green">+2.70</span></td>
								<td><span class="inv-green">+2.81%</span></td>
								<td>75,311,762</td>
							</tr>
							<tr>
								<td>MSFT</td>
								<td>Microsoft Corporation</td>
								<td>49.83</td>
								<td><span class="inv-green">+2.08</span></td>
								<td><span class="inv-green">+4.01%</span></td>
								<td>133,502,263</td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="losers">
						<table class="table table-striped">
							<thead>
							<tr>
								<th>Symbol</th>
								<th>Company Name</th>
								<th>Price</th>
								<th>Change</th>
								<th>% Change</th>
								<th>Volume</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>BAC</td>
								<td>Bank of America Corporation</td>
								<td>13.04</td>
								<td><span class="inv-red">-1.04</span></td>
								<td><span class="inv-red">-7.41%</span></td>
								<td>239,499,186</td>
							</tr>
							<tr>
								<td>MSFT</td>
								<td>Microsoft Corporation</td>
								<td>49.83</td>
								<td><span class="inv-red">-2.08</span></td>
								<td><span class="inv-red">-4.01%</span></td>
								<td>133,502,263</td>
							</tr>
							<tr>
								<td>AAPL</td>
								<td>Apple Inc.</td>
								<td>93.40</td>
								<td><span class="inv-red">-2.70</span></td>
								<td><span class="inv-red">-2.81%</span></td>
								<td>75,311,762</td>
							</tr>
							<tr>
								<td>BAC</td>
								<td>Bank of America Corporation</td>
								<td>13.04</td>
								<td><span class="inv-red">-1.04</span></td>
								<td><span class="inv-red">-7.41%</span></td>
								<td>239,499,186</td>
							</tr>
							<tr>
								<td>MSFT</td>
								<td>Microsoft Corporation</td>
								<td>49.83</td>
								<td><span class="inv-red">-2.08</span></td>
								<td><span class="inv-red">-4.01%</span></td>
								<td>133,502,263</td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-md-4">
				<ul class="nav nav-pills nav-pills-custom-minimal custom-minimal-bottom" role="tablist">
					<li class="active"><a href="#majors" role="tab" data-toggle="tab">Majors</a></li>
					<li><a href="#americas" role="tab" data-toggle="tab">Americas</a></li>
					<li><a href="#emea" role="tab" data-toggle="tab">EMEA</a></li>
				</ul>
				<div class="tab-content">
					<div class="tab-pane fade in active" id="majors">
						<table class="table table-striped">
							<thead>
							<tr>
								<th>Currency</th>
								<th>Price</th>
								<th>Change</th>
								<th>% Change</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>EUR/USD</td>
								<td>1.1067</td>
								<td><span class="inv-green">+0.0001</span></td>
								<td><span class="inv-green">+0.01%</span></td>
							</tr>
							<tr>
								<td>USD/JPY</td>
								<td>105.815</td>
								<td><span class="inv-red">-0.361</span></td>
								<td><span class="inv-red">-0.33%</span></td>
							</tr>
							<tr>
								<td>GBP/USD</td>
								<td>1.3238</td>
								<td><span class="inv-red">-0.0013</span></td>
								<td><span class="inv-red">-0.10%</span></td>
							</tr>
							<tr>
								<td>AUD/USD</td>
								<td>0.7543</td>
								<td><span class="inv-green">+0.3452</span></td>
								<td><span class="inv-green">+0.46%</span></td>
							</tr>
							<tr>
								<td>EUR/JPY</td>
								<td>117.068</td>
								<td><span class="inv-green">+0.0001</span></td>
								<td><span class="inv-green">+0.21%</span></td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="americas">
						<table class="table table-striped">
							<thead>
							<tr>
								<th>Currency</th>
								<th>Price</th>
								<th>Change</th>
								<th>% Change</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>USD/CAD</td>
								<td>1.2974</td>
								<td><span class="inv-green">+0.0029</span></td>
								<td><span class="inv-green">+0.22%</span></td>
							</tr>
							<tr>
								<td>USD/MXN</td>
								<td>18.4086</td>
								<td><span class="inv-green">+0.0237</span></td>
								<td><span class="inv-green">+0.13%</span></td>
							</tr>
							<tr>
								<td>USD/BRL</td>
								<td>3.2547</td>
								<td><span class="inv-red">-0.0265</span></td>
								<td><span class="inv-red">-0.81%</span></td>
							</tr>
							<tr>
								<td>USD/CLP</td>
								<td>648.7395</td>
								<td><span class="inv-red">-3.6100</span></td>
								<td><span class="inv-red">-0.55%</span></td>
							</tr>
							<tr>
								<td>USD/PEN</td>
								<td>3.2890</td>
								<td><span class="inv-green">+0.0059</span></td>
								<td><span class="inv-green">+0.18%</span></td>
							</tr>
							</tbody>
						</table>
					</div>
					<div class="tab-pane fade" id="emea">
						<table class="table table-striped">
							<thead>
							<tr>
								<th>Currency</th>
								<th>Price</th>
								<th>Change</th>
								<th>% Change</th>
							</tr>
							</thead>
							<tbody>
							<tr>
								<td>EUR/USD</td>
								<td>1.1067</td>
								<td><span class="inv-green">+0.0001</span></td>
								<td><span class="inv-green">+0.01%</span></td>
							</tr>
							<tr>
								<td>GBP/USD</td>
								<td>1.3238</td>
								<td><span class="inv-red">-0.0013</span></td>
								<td><span class="inv-red">-0.10%</span></td>
							</tr>
							<tr>
								<td>USD/CHF</td>
								<td>0.9829</td>
								<td><span class="inv-green">+0.0005</span></td>
								<td><span class="inv-green">+0.05%</span></td>
							</tr>
							<tr>
								<td>USD/PEN</td>
								<td>3.2890</td>
								<td><span class="inv-green">+0.0059</span></td>
								<td><span class="inv-green">+0.18%</span></td>
							</tr>
							<tr>
								<td>USD/CLP</td>
								<td>648.7395</td>
								<td><span class="inv-red">-3.6100</span></td>
								<td><span class="inv-red">-0.55%</span></td>
							</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4">
				<div class="market-news">
					<h3 class="heading">Top News</h3>
					<ul class="list-unstyled">
						<li>
							<a href="#" class="news-thumbnail"><img src="${contextRoot}/assets/img/market-news.jpg" class="img-responsive" alt="Top News"></a>
							<a href="#" class="title">Intrinsicly leverage existing state of the art metrics with integrated niche markets</a>
						</li>
						<li>
							<a href="#" class="title">Enthusiastically formulate leveraged technologies</a>
						</li>
						<li>
							<a href="#" class="title">Efficiently drive mission-critical applications rather than real-time</a>
						</li>
						<li>
							<a href="#" class="title">Proactively harness backward-compatible core competencies with fully</a>
						</li>
						<li>
							<a href="#" class="title">Credibly drive sustainable networks</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-md-4">
				<div class="market-news">
					<h3 class="heading">Economy</h3>
					<ul class="list-unstyled">
						<li>
							<a href="#" class="news-thumbnail"><img src="${contextRoot}/assets/img/market-news2.jpg" class="img-responsive" alt="Top News"></a>
							<a href="#" class="title">Conveniently communicate transparent markets for transparent testing procedures</a>
						</li>
						<li>
							<a href="#" class="title">Holisticly aggregate an expanded array of synergy</a>
						</li>
						<li>
							<a href="#" class="title">Assertively incubate backward-compatible niche markets without focused sources</a>
						</li>
						<li>
							<a href="#" class="title">Conveniently pursue mission-critical relationships through error-free innovation</a>
						</li>
						<li>
							<a href="#" class="title">Assertively implement value-added scenarios whereas global action items</a>
						</li>
					</ul>
				</div>
			</div>
			<div class="col-md-4">
				<div class="market-news">
					<h3 class="heading">Finance</h3>
					<ul class="list-unstyled">
						<li>
							<a href="#" class="news-thumbnail"><img src="${contextRoot}/assets/img/market-news3.jpg" class="img-responsive" alt="Top News"></a>
							<a href="#" class="title">Quickly conceptualize enabled human capital </a>
						</li>
						<li>
							<a href="#" class="title">Globally enable collaborative manufactured products</a>
						</li>
						<li>
							<a href="#" class="title">Completely monetize resource maximizing imperatives</a>
						</li>
						<li>
							<a href="#" class="title">Holisticly mesh robust channels with emerging capital</a>
						</li>
						<li>
							<a href="#" class="title">Globally evisculate high-payoff</a>
						</li>
					</ul>
				</div>
			</div>
		</div>
	</div>
</div>