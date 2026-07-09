Return-Path: <netfilter-devel+bounces-13791-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OW3gBneRT2pnjwIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13791-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 14:17:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD42730E5A
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 14:17:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=netfilter.org header.s=2025 header.b=VzRyf3Ze;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13791-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13791-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A1C1300B115
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 12:17:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 956273128BE;
	Thu,  9 Jul 2026 12:17:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9065739B97B
	for <netfilter-devel@vger.kernel.org>; Thu,  9 Jul 2026 12:17:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783599473; cv=none; b=gpVdi86nrOO2DCcia0kPKXLsYothh2VUa71X6v0amqDh9H1e64SekjPjiuWVaNc1h5aKGi8BidtBtFATe698fT86bBf88oSW0lMGNM51VvkqukIXQPndpVZMrkPifrIXXJyRogH/9DmMpL/32QOkso7WE+4IG3+VuFoDPrTsLFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783599473; c=relaxed/simple;
	bh=yYb/npEjM65CtjlgEAkFWN/dGbHExmMmuNg0bfID/Po=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mkhQSAbs1ijQNQy2Ms/+h31lbC+FXh7KWa1VGkPExPEoPhR9vPF7CjqWK8sYVjErXyHo4ixbTliXsW7PshGF8WvouhFYgSt6DVsZ1ffZWqS9ATuwF0rvkJzGMsCclQrO2fJ6O4oiwOOkVyx4JPg5XuDC75l00p+TcURZ2b4qs08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=VzRyf3Ze; arc=none smtp.client-ip=217.70.190.124
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with UTF8SMTPSA id 8794460586;
	Thu,  9 Jul 2026 14:17:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1783599469;
	bh=/9jVPewlhdZCr3k+xQV4YNzyEIzSoCdWTXCZSKcN6j4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzRyf3ZeLSVxQDTMSxG9UYRZvQ2AZpNB8lPGlS+8xXmH1BEfQkY6Vf4eOL0aZ9+Z4
	 aaET2GIN2M3rvpNxIZ1+daeqDEy/DPeRNBaatCLz/2gl1gK7qDDsV7lW/npkDrHnVm
	 VzzHQk1ltYqsMT7I5aEsFrpPn0iHTlkhZhOaierBZMCLbR6AojxoJQgmx64zk6MLA4
	 BYdH77NaCBgrJuaZ+pQ3TGyfFYBtbP1nVZnO5BTMMVBejr1roTwLN5JGTnd8/nd3RL
	 W6Jnx3DdkA8ttYDLhXrO9TH0kIjFOL+ycPMx3SbixExJLC/Mxyj2Lr6BUZIUXXAE97
	 jeaBn8wcDGMMQ==
Date: Thu, 9 Jul 2026 14:17:46 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netfilter-devel@vger.kernel.org, fw@strlen.de, phil@nwl.cc,
	lorenzo@kernel.org, yuantan098@gmail.com, yifanwucs@gmail.com,
	tomapufckgml@gmail.com, bird@lzu.edu.cn, chzhengyang2023@lzu.edu.cn
Subject: Re: [PATCH nf v3 2/2] selftests: netfilter: add bridge tunnel
 flowtable regression
Message-ID: <ak-RagPZKnoZKCou@chamomile>
References: <cover.1782092221.git.chzhengyang2023@lzu.edu.cn>
 <5b8a9e87ff7b47401612bb0e0fc841d8bfdd333d.1782092221.git.chzhengyang2023@lzu.edu.cn>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5b8a9e87ff7b47401612bb0e0fc841d8bfdd333d.1782092221.git.chzhengyang2023@lzu.edu.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[netfilter.org:s=2025];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:n05ec@lzu.edu.cn,m:netfilter-devel@vger.kernel.org,m:fw@strlen.de,m:phil@nwl.cc,m:lorenzo@kernel.org,m:yuantan098@gmail.com,m:yifanwucs@gmail.com,m:tomapufckgml@gmail.com,m:bird@lzu.edu.cn,m:chzhengyang2023@lzu.edu.cn,s:lists@lfdr.de];
	DMARC_NA(0.00)[netfilter.org];
	TAGGED_FROM(0.00)[bounces-13791-lists,netfilter-devel=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,strlen.de,nwl.cc,kernel.org,gmail.com,lzu.edu.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pablo@netfilter.org,netfilter-devel@vger.kernel.org];
	DKIM_TRACE(0.00)[netfilter.org:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netfilter-devel];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chamomile:mid,vger.kernel.org:from_smtp,netfilter.org:from_mime,netfilter.org:dkim,sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5BD42730E5A

On Mon, Jun 22, 2026 at 06:10:27PM +0800, Ren Wei wrote:
> From: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
> 
> Add a nft_flowtable.sh regression test for the bridge direct-xmit plus
> IPIP/IP6IP6 underlay configuration that reproduces the reachable
> DIRECT+tunnel tuple combination exercised by the flowtable fix.
> 
> The test reuses the existing bridge and tunnel topology, installs flow
> rules for the tunnel egress and bridge reply path, verifies IPv4 and
> IPv6 forwarding, and checks the flowtable counters after the transfer.

Hm, this selftest extension did not help to catch this issue:

https://sashiko.dev/#/patchset/20260709114025.1294044-1-pablo%40netfilter.org

This selftest extension is not yet in the tree, I remember it helped
me reproduce the crash that was reported here, but it did not help to
detect that this is incorrectly setting up flowtable path.

> Signed-off-by: Zhengyang Chen <chzhengyang2023@lzu.edu.cn>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
> changes in v3:
>   - Add nft_flowtable.sh coverage for the bridge direct-xmit plus
>     IPIP/IP6IP6 underlay case
>   - v2 Link: https://lore.kernel.org/all/7016923271a6bb3e26f9a21757922d3c5b1a7487.1781683535.git.chzhengyang2023@lzu.edu.cn/
> ---
>  .../selftests/net/netfilter/nft_flowtable.sh  | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
> 
> diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> index 7a34ef468975..cecbec148bdb 100755
> --- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> +++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
> @@ -736,6 +736,61 @@ if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "on bridge"; then
>  	ret=1
>  fi
>  
> +if ip -net "$nsr1" link show tun0 > /dev/null 2>&1 &&
> +   ip -net "$nsr2" link show tun0 > /dev/null 2>&1; then
> +	ip -net "$nsr1" route change default via 192.168.100.2
> +	ip -net "$nsr2" route change default via 192.168.100.1
> +	ip -6 -net "$nsr1" route delete default
> +	ip -6 -net "$nsr1" route add default via fee1:3::2
> +	ip -6 -net "$nsr2" route delete default
> +	ip -6 -net "$nsr2" route add default via fee1:3::1
> +	ip -net "$ns2" route add default via 10.0.2.1
> +	ip -6 -net "$ns2" route add default via dead:2::1
> +
> +	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
> +		'meta oif "tun0" tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
> +	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
> +		'meta oif "tun6" tcp dport 12345 ct mark set 1 flow add @f1 counter name routed_orig accept'
> +	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
> +		'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
> +	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
> +		'meta oif "br0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
> +	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
> +		'meta oif "tun0" accept'
> +	ip netns exec "$nsr1" nft -a insert rule inet filter forward \
> +		'meta oif "tun6" accept'
> +
> +	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
> +
> +	if test_tcp_forwarding "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
> +		check_counters "bridge + IPIP tunnel"
> +	else
> +		echo "FAIL: flow offload for ns1/ns2 with bridge + IPIP tunnel" 1>&2
> +		ip netns exec "$nsr1" nft list ruleset
> +		ret=1
> +	fi
> +
> +	if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
> +		check_counters "bridge + IP6IP6 tunnel"
> +	else
> +		echo "FAIL: flow offload for ns1/ns2 with bridge + IP6IP6 tunnel" 1>&2
> +		ip netns exec "$nsr1" nft list ruleset
> +		ret=1
> +	fi
> +
> +	ip -net "$nsr1" route change default via 192.168.10.2
> +	ip -net "$nsr2" route change default via 192.168.10.1
> +	ip -net "$ns2" route del default via 10.0.2.1
> +	ip -6 -net "$nsr1" route delete default
> +	ip -6 -net "$nsr1" route add default via fee1:2::2
> +	ip -6 -net "$nsr2" route delete default
> +	ip -6 -net "$nsr2" route add default via fee1:2::1
> +	ip -6 -net "$ns2" route del default via dead:2::1
> +else
> +	echo "SKIP: bridge + tunnel flowtable regression (tun0 missing)"
> +	[ "$ret" -eq 0 ] && ret=$ksft_skip
> +fi
> +
>  
>  # Another test:
>  # Add bridge interface br0 to Router1, with NAT and VLAN.
> -- 
> 2.43.0
> 

