Return-Path: <netfilter-devel+bounces-12866-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKsAGHfLFWqQbgcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12866-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 18:33:59 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 71EF55D9C49
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 18:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 884CA302921D
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 16:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560513B38B0;
	Tue, 26 May 2026 16:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H5wCsFUe"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A5B3B27EE;
	Tue, 26 May 2026 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779812414; cv=none; b=WwctoFZCzox+nwUcWKsxtL/Wx3w4GtzmymZ4cg/v4ChPFPh58AB7FWa6xGVrrAmrW7vBDAIp4g2E61tj84Y2QpFN4Hu+7jI25gpO46Nn6tvGa/BflJTh3gDfh+fgWvuyykSQCpHa5AXML+3zLSra1Nh7cxgNWymPhY4IGnUAlu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779812414; c=relaxed/simple;
	bh=+XLjAnpY0unB67nbg87e232NzbGjChx2swTu8HKQO4A=;
	h=Content-Type:MIME-Version:Message-Id:In-Reply-To:References:
	 Subject:From:To:Cc:Date; b=jpmWyTutu7cpYX/QZDkfgbGL4amcu5hdPr043P3BK9kS6yx/Rs/2R3Ru9ZcssGrusGHXCUI+DJxj1N1458l5fnJd5xVfLwZfZ2T6uteUz7nwkEwyAxq1B0H8mFww2u0LQGTdCOhiRRunHD0B+EsCHEeFv1TCrLPzfhSOSsl+AiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H5wCsFUe; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 340341F000E9;
	Tue, 26 May 2026 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779812412;
	bh=SU/C5hMx3jXUsOUwsZTH9TaiXLT9pBNB1gWC2GAYxB8=;
	h=In-Reply-To:References:Subject:From:To:Cc:Date;
	b=H5wCsFUe+JTpcjRMW/O1Gw4OLYgCSw2wr1zZw6rRK8RylisVUIc6rHWBt+NXFzt9a
	 kX60ozmNWZeqD1dh7K2UjqpoaI4Gj5Pw5bwDQjLxDY0fUkyMMGDlDurN5+BbhkfGz6
	 Djk+eWpNYFONHyajlAHewiTr7AZDk9QnVjE43N1/u20OCsi3Oib4L6sJbLe2BgJC2L
	 MlAaQXErTCosiOOU2k373c0+rcv8rjJupbky4FzO0ka9E3be3z2vwee5FmLpiNxpKG
	 23LT/qyWT5HWoWpyQS8EGaiBRRkiaXJ1xRxHU8kI5h0fML6XbYq1KzREejmPnP2OSX
	 xTZdezlTkyRXQ==
Content-Type: multipart/mixed; boundary="===============7371411648816245416=="
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <1dd140384d8509230a38c31f8753dec9a21f77f585178e41a60746b5f631fb40@mail.kernel.org>
In-Reply-To: <20260526153708.279717-5-mahe.tardy@gmail.com>
References: <20260526153708.279717-5-mahe.tardy@gmail.com>
Subject: Re: [PATCH bpf-next v7 4/7] selftests/bpf: add bpf_icmp_send kfunc cgroup_skb tests
From: bot+bpf-ci@kernel.org
To: mahe.tardy@gmail.com,bpf@vger.kernel.org
Cc: martin.lau@linux.dev,daniel@iogearbox.net,john.fastabend@gmail.com,ast@kernel.org,andrii@kernel.org,yonghong.song@linux.dev,jordan@jrife.io,netdev@vger.kernel.org,netfilter-devel@vger.kernel.org,edumazet@google.com,kuba@kernel.org,pabeni@redhat.com,mahe.tardy@gmail.com,ast@kernel.org,andrii@kernel.org,daniel@iogearbox.net,martin.lau@kernel.org,eddyz87@gmail.com,yonghong.song@linux.dev,clm@meta.com,ihor.solodrai@linux.dev
Date: Tue, 26 May 2026 16:20:12 +0000 (UTC)
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	CTYPE_MIXED_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-12866-lists,netfilter-devel=lfdr.de,bpf-ci];
	FREEMAIL_CC(0.00)[linux.dev,iogearbox.net,gmail.com,kernel.org,jrife.io,vger.kernel.org,google.com,redhat.com,meta.com];
	FROM_NEQ_ENVFROM(0.00)[bot@kernel.org,netfilter-devel@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+,1:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[23];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.kernel.org:mid]
X-Rspamd-Queue-Id: 71EF55D9C49
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--===============7371411648816245416==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

> diff --git a/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> new file mode 100644
> index 000000000000..0dc6b6ceafb4
> --- /dev/null
> +++ b/tools/testing/selftests/bpf/prog_tests/icmp_send_kfunc.c
> @@ -0,0 +1,149 @@

[ ... ]

> +static void trigger_prog_read_icmp_errqueue(struct icmp_send *skel, int code)
> +{
> +	int srv_fd = -1, client_fd = -1;
> +	struct sockaddr_in addr;
> +	socklen_t len = sizeof(addr);
> +
> +	srv_fd = start_server(AF_INET, SOCK_STREAM, "127.0.0.1", 0, TIMEOUT_MS);
> +	if (!ASSERT_GE(srv_fd, 0, "start_server"))
> +		return;

Jordan Rife raised a style concern in v6 about using ASSERT_OK_FD
instead of ASSERT_GE for file descriptor checks. While this was addressed
for client_fd and cgroup_fd, the srv_fd check here still uses ASSERT_GE.
Should this be ASSERT_OK_FD for consistency?

https://lore.kernel.org/bpf/q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz/

[ ... ]

> +void test_icmp_send_unreach_cgroup(void)
> +{
> +	struct icmp_send *skel;
> +	int cgroup_fd = -1;
> +
> +	skel = icmp_send__open_and_load();
> +	if (!ASSERT_OK_PTR(skel, "skel_open"))
> +		goto cleanup;
> +
> +	cgroup_fd = test__join_cgroup("/icmp_send_unreach_cgroup");
> +	if (!ASSERT_OK_FD(cgroup_fd, "join_cgroup"))
> +		goto cleanup;
> +
> +	skel->links.egress =
> +		bpf_program__attach_cgroup(skel->progs.egress, cgroup_fd);
> +	if (!ASSERT_OK_PTR(skel->links.egress, "prog_attach_cgroup"))
> +		goto cleanup;
> +
> +	for (int code = 0; code <= NR_ICMP_UNREACH; code++) {
> +		/* The TCP stack reacts differently when asking for
> +		 * fragmentation, let's ignore it for now.
> +		 */
> +		if (code == ICMP_FRAG_NEEDED)
> +			continue;
> +
> +		trigger_prog_read_icmp_errqueue(skel, code);
> +		ASSERT_EQ(skel->data->kfunc_ret, 0, "kfunc_ret");
> +	}
> +
> +	/* Test an invalid code */
> +	trigger_prog_read_icmp_errqueue(skel, -1);
> +	ASSERT_EQ(skel->data->kfunc_ret, -EINVAL, "kfunc_ret");
> +
> +cleanup:
> +	icmp_send__destroy(skel);
> +	close(cgroup_fd);

Jordan Rife raised a concern in v6 about the cleanup path potentially
closing an invalid file descriptor. Should this be guarded with
'if (cgroup_fd != -1)' before calling close(cgroup_fd)?

https://lore.kernel.org/bpf/q46w47cqezttz2otf76tncxu7sovhywy2dqwcbajigp64uhbtz@eimvxfeeexuz/

> +}

[ ... ]


---
AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md

CI run summary: https://github.com/kernel-patches/bpf/actions/runs/26459248718
--===============7371411648816245416==--

