Return-Path: <netfilter-devel+bounces-10414-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI6RKZ+md2lrjwEAu9opvQ
	(envelope-from <netfilter-devel+bounces-10414-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 18:38:39 +0100
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2957E8B91B
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 18:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 25408300E275
	for <lists+netfilter-devel@lfdr.de>; Mon, 26 Jan 2026 17:38:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD1734D4D2;
	Mon, 26 Jan 2026 17:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b="tM7DlsVW"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A120E168BD
	for <netfilter-devel@vger.kernel.org>; Mon, 26 Jan 2026 17:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769449117; cv=none; b=C6ug3hdsmncA7ZfDK8YWU2XURmby080dtfIUwPZ8Q/Gnz6XiN2CdvY5BpTrHKLd1sHCp3pRRcwpiDWzJrdB7vfehM/82DeACcXqFQa9Jx5smAHQ0qlKiQwHmmeNhBT9EaQZR0zaOCKv2S621ytXw07dAwUxB2UMx+4Jhq/tgZRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769449117; c=relaxed/simple;
	bh=h6RfDwqM0jPtCc0y5wIl196B98bx6odnfoUTokMUQE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZZL4AsPOX1rjJyQ+uVIbh7uDBzhTmBDl1IZxTSAI7j+0J7wuFnt7Ji3mdrqCyGoTNcLUWdHMoI7WCymrsd5MZ1XOl1jwX3hxPvskN7fdbsEGjHkZ7AlJTGbdmwX9uCIMzdjc6u8IxqjsTunbcXK3ZNXPwq3QpLwdIEvyvHMundk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com; spf=pass smtp.mailfrom=mailfence.com; dkim=pass (2048-bit key) header.d=mailfence.com header.i=brianwitte@mailfence.com header.b=tM7DlsVW; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailfence.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailfence.com
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id E8D8C295F;
	Mon, 26 Jan 2026 18:38:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769449111;
	s=20240605-akrp; d=mailfence.com; i=brianwitte@mailfence.com;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=h6RfDwqM0jPtCc0y5wIl196B98bx6odnfoUTokMUQE0=;
	b=tM7DlsVWhn+0AES1Ris2H4WXBSTrJhwSHzKFt+eMbX5fDuHOC/h7zQgBYlJlMxzE
	2+YqVAb+ugTFfYyhBrQQpX0IS7m9Cul4JNwKwqD4WFHoFVyhNpG3nRL9v1kPywx01z+
	I3ZYCO54HDDPiVV2bZh/pV/9Rxtepo2i9fP1IY+NL/03PtCvzFK9C1/zPFeIzrlMDhQ
	nMQ8cn7hFIpZkXZkYHRXYdfXyt5kHWd3kguNawrh+tncnoJqvEKeqVhVMlz7xsWfJS8
	ywoGjm1i2MggW4hA0N+zbC/0mybwSv24AXUmkEBCNtF63WgulTjFZ2dWsNPu7DpKg7N
	SkqyXwOk+g==
Received: by smtp.mailfence.com with ESMTPSA ; Mon, 26 Jan 2026 18:38:29 +0100 (CET)
From: Brian Witte <brianwitte@mailfence.com>
To: fw@strlen.de
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH] datatype: fix ether address parsing of integer values
Date: Mon, 26 Jan 2026 11:38:12 -0600
Message-ID: <20260126173812.56922-1-brianwitte@mailfence.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <aXdZNS1fL36NL5vB@strlen.de>
References: <aXdZNS1fL36NL5vB@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ContactOffice-Account: com:441463380
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[mailfence.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[mailfence.com:s=20240605-akrp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[mailfence.com:+];
	TAGGED_FROM(0.00)[bounces-10414-lists,netfilter-devel=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brianwitte@mailfence.com,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2957E8B91B
X-Rspamd-Action: no action

Florian Westphal <fw@strlen.de> wrote:
> Yes, but it looks like it breaks backwards compatibility.
>
> 'ether daddr 99' is parsed as 00:00:00:00:00:99.
> After your patch, its parsed as 00:00:00:00:00:63.
>
> So I'm not sure we can fix this.

You're right, I hadn't considered that case. Thanks for the review.

Brian

