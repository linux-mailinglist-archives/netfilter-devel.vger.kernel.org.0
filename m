Return-Path: <netfilter-devel+bounces-12843-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHUaM/pRFWqmUQcAu9opvQ
	(envelope-from <netfilter-devel+bounces-12843-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 09:55:38 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DE335D21FA
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 09:55:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E238304BD8A
	for <lists+netfilter-devel@lfdr.de>; Tue, 26 May 2026 07:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE73372EE0;
	Tue, 26 May 2026 07:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b="Hg6osnWx"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from smtp-out.kfki.hu (smtp-out.kfki.hu [148.6.0.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE92C0282;
	Tue, 26 May 2026 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.6.0.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779781910; cv=none; b=Q681eSo9ciHUXlER3hT5GEkH4lObiHR0gzQntDgtCc7e7/VVqvnr6p55vJ5vSg4jxVYf2YHJlJMLQ6BtGmlZiemDHE60Lc/eQ+LKI5eUKKzqRLXf0jK4NnU6Im1ZU/6qYfsmpmG4V7Y05hR66ExvdsVs/+pCsynBbWmvt0ZrDb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779781910; c=relaxed/simple;
	bh=N8+AfC6fmd8Up6lIsp7vxRJqz7S9+IYEWKO/r65Wpw0=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=uiidwDQ9adZNap/zlesNn1YwtuaAx12r2ZyEV8GqRfAdgEKeu81Q4R2k471zE7narTT79wa1rPokmO6OWScWdiT/jtg6GTOMen8DQHR+nOCK2tz0Upzn8m44VUy79LxSrmMGsGL3pp6hKQoRPVR7GZWmKEkm01Fojl/asXAwAbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu; spf=pass smtp.mailfrom=blackhole.kfki.hu; dkim=pass (1024-bit key) header.d=blackhole.kfki.hu header.i=@blackhole.kfki.hu header.b=Hg6osnWx; arc=none smtp.client-ip=148.6.0.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=blackhole.kfki.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blackhole.kfki.hu
Received: from localhost (localhost [127.0.0.1])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4gPlLz2zB3z7s85G;
	Tue, 26 May 2026 09:51:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	blackhole.kfki.hu; h=mime-version:references:message-id
	:in-reply-to:from:from:date:date:received:received:received
	:received; s=20151130; t=1779781897; x=1781596298; bh=cG8F7H3o7F
	Xzzc8m8fPOPB5omyJ+Ncr5BOer8ss8ZEg=; b=Hg6osnWx6h4D0OcSg+8iG3yeeH
	9EjOfB2D5sQsC4wk0ZjTJMEK6uioclMAUXva5bK/Jyj6DFxCyHqKxtRQ2AcTVoim
	abqj+Qlr5L0S9gWkuPCbq27jm2m0KatJ2a/lhit+VQpTywTqTtLiTN9jE0FUtFxW
	iRVjRV3c+W6acJHrM=
X-Virus-Scanned: Debian amavis at smtp2.kfki.hu
Received: from smtp2.kfki.hu ([127.0.0.1])
 by localhost (smtp2.kfki.hu [127.0.0.1]) (amavis, port 10026) with ESMTP
 id 15ycL2Z75VFJ; Tue, 26 May 2026 09:51:37 +0200 (CEST)
Received: from blackhole.kfki.hu (blackhole.szhk.kfki.hu [IPv6:2001:738:5001:1::240:2])
	by smtp2.kfki.hu (Postfix) with ESMTP id 4gPlLx05nMz7s85F;
	Tue, 26 May 2026 09:51:36 +0200 (CEST)
Received: by blackhole.kfki.hu (Postfix, from userid 1000)
	id E92EE34316A; Tue, 26 May 2026 09:51:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by blackhole.kfki.hu (Postfix) with ESMTP id E8659340D75;
	Tue, 26 May 2026 09:51:36 +0200 (CEST)
Date: Tue, 26 May 2026 09:51:36 +0200 (CEST)
From: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
To: imnozi@gmail.com
cc: Kerin Millar <kfm@plushkava.net>, netfilter-devel@vger.kernel.org, 
    netfilter@vger.kernel.org
Subject: Re: ipset not completely working in mangle:PREROUTING
In-Reply-To: <20260525235754.4943a2b6@playground>
Message-ID: <1c466022-e165-fda9-f356-8fdd4d474e15@blackhole.kfki.hu>
References: <20260525205736.1c76666f@playground> <a276ecef-e609-4d55-bc71-ddb9c9ff2f3c@app.fastmail.com> <20260525235754.4943a2b6@playground>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[blackhole.kfki.hu,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[blackhole.kfki.hu:s=20151130];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-12843-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,plushkava.net:email,blackhole.kfki.hu:mid,blackhole.kfki.hu:dkim];
	FREEMAIL_TO(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[blackhole.kfki.hu:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kadlec@blackhole.kfki.hu,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netfilter-devel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 1DE335D21FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On Mon, 25 May 2026, imnozi@gmail.com wrote:

> On Tue, 26 May 2026 02:57:38 +0100
> "Kerin Millar" <kfm@plushkava.net> wrote:
>
>> On Tue, 26 May 2026, at 1:57 AM, imnozi@gmail.com wrote:
>>> iptables v1.8.7 (legacy)
>>> ipset v6.34, protocol version: 6

That's pretty old. Still it has no effect on the subject.

> OK. So ipset *should* work in mangle:PREROUTING.

Yes, but please note: if some data it should match on is missing at that 
stage/chain (like incoming-outgoing interface), then it "won't work".

> Can the same chain name be used simultaneously in multiple tables 
> (though if not, the pre-defined chains shouldn't work)?

No, all tables are independent of each other, including the predefined 
chains.

Best regards,
Jozsef


