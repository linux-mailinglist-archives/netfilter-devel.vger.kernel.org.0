Return-Path: <netfilter-devel+bounces-13394-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W1cfF9MtOWoSoAcAu9opvQ
	(envelope-from <netfilter-devel+bounces-13394-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 14:42:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DFC6AF843
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 14:42:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AoBr3cFW;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13394-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13394-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 575EA30131B6
	for <lists+netfilter-devel@lfdr.de>; Mon, 22 Jun 2026 12:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554FF3ACA6C;
	Mon, 22 Jun 2026 12:41:53 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0053ACA4D;
	Mon, 22 Jun 2026 12:41:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782132113; cv=none; b=qrD3adp/flu/cnDLziXOo8sl2mhIwXPMUlPcO+tgGgTpDFFqpTTmZpSLTUzvDE/GVUAFiTnbhIti+dIe0/DG1rdy3STAlxyEDSL1oZdBsn0M3up2xARO6/rAxjjFCgz8fVQp27kWuX7yXPRXEIzw0RFG6e3TNzow35DwopJhKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782132113; c=relaxed/simple;
	bh=Qa37l2oKigR9pQAX14SRmhe7GVOhrs77ovCT0t8TzNk=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=uvhF7ko69ErbkuzwO1LQH8drbaFceL1q61KE09GGS4mz6c94MkGaRCWnDKM82M14Wb84LY986vlv/PIPKuPphVSG9/56UMrqOA4/shd7WPmknzYtkP5qZ6hGPWSdQaSiG56EkgkaXrq4VRzpBtVLk3fDA/Q4mJ2UfYpeXgsfhW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AoBr3cFW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E37AB1F000E9;
	Mon, 22 Jun 2026 12:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782132112;
	bh=EOkVO45K62l8VKN8Fk4OkVt2kOYAzSbLqumt/UHZiJ8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=AoBr3cFWETMDWTov6SWOTqs7Zkc/MoTjUaigHfq+PueM0LL4bn2vgjFfh0f68iqmJ
	 NZ7HlmSC+a/1aFNz2TXnrB+z2llvfahGdSKwiBONl2Buju4b05v4M9QAa9bNgIzkxu
	 Kn0du/Ox1m1ocw/uqR/ykqYeTcS1C8teRRfT0tLNDflO44RYUSGUGijslC0J8qAP67
	 wqsE8S6gVPVifVaVk86vc12WFoXXGK9zgSBN1jzL+9N/8Fz5XrZvdNKnbcEcfmpZW1
	 RrubKL8GmfT5yPL7+kfjAI93VjQl3ucCxUVqD7n3/9YLb3lzlR+PY82fFf4983+2ow
	 /IgpsWf9n40Wg==
Content-Type: multipart/mixed; boundary="===============5842488995928438146=="
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <ba7b7c89fb653fc822046f04c87e0406bccce8fb75c0af274527159373c4c04a@mail.kernel.org>
In-Reply-To: <20260622120515.137082-7-mahe.tardy@gmail.com>
References: <20260622120515.137082-7-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v8 6/7] selftests/bpf: add bpf_icmp_send kfunc tc tests
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: andrii@kernel.org,ast@kernel.org,daniel@iogearbox.net,edumazet@google.com,john.fastabend@gmail.com,jordan@jrife.io,kuba@kernel.org,martin.lau@linux.dev,netdev@vger.kernel.org,netfilter-devel@vger.kernel.org,pabeni@redhat.com,yonghong.song@linux.dev,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Mon, 22 Jun 2026 12:41:51 +0000 (UTC)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	CTYPE_MIXED_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+];
	TAGGED_FROM(0.00)[bounces-13394-lists,netfilter-devel=lfdr.de,bpf-ci];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,gmail.com,jrife.io,linux.dev,vger.kernel.org,redhat.com,meta.com];
	FORGED_RECIPIENTS(0.00)[m:mahe.tardy@gmail.com,m:bpf@vger.kernel.org,m:andrii@kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:edumazet@google.com,m:john.fastabend@gmail.com,m:jordan@jrife.io,m:kuba@kernel.org,m:martin.lau@linux.dev,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:pabeni@redhat.com,m:yonghong.song@linux.dev,m:martin.lau@kernel.org,m:eddyz87@gmail.com,m:clm@meta.com,m:ihor.solodrai@linux.dev,m:mahetardy@gmail.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[23];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,mail.kernel.org:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 59DFC6AF843

--===============5842488995928438146==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> index a5ac1a6ea77a..66447681f72d 100644
> --- a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -178,3 +178,28 @@ void test_icmp_send_unreach_cgroup(void)
>  	if (cgroup_fd >= 0)
>  		close(cgroup_fd);
>  }
> +
> +void test_icmp_send_unreach_tc(void)
> +{
> +	LIBBPF_OPTS(bpf_tcx_opts, opts);
> +	struct icmp_send *skel;
> +	struct bpf_link *link = NULL;
> +
> +	skel = icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	link = bpf_program__attach_tcx(skel->progs.tc_egress, 1, &opts);

This isn't a bug, but would a named constant read more clearly here than
the bare ifindex literal 1? Looking at prog_tests/tc_change_tail.c, it
defines LO_IFINDEX for this same purpose, and prog_tests/tc_links.c
resolves the loopback interface via if_nametoindex("lo").

> +	if (!ASSERT_OK_PTR(link, "prog_attach"))
> +		goto cleanup;
> +
> +	if (test__start_subtest("ipv4"))
> +		run_icmp_test(skel, AF_INET, "127.0.0.1", NR_ICMP_UNREACH);
> +
> +	if (test__start_subtest("ipv6"))
> +		run_icmp_test(skel, AF_INET6, "::1", ICMPV6_REJECT_ROUTE);
> +
> +cleanup:
> +	bpf_link__destroy(link);
> +	icmp_send__destroy(skel);
> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/27951892371
--===============5842488995928438146==--

