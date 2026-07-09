Return-Path: <netfilter-devel+bounces-13794-lists+netfilter-devel=lfdr.de@vger.kernel.org>
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQEjNRGeT2qNlAIAu9opvQ
	(envelope-from <netfilter-devel+bounces-13794-lists+netfilter-devel=lfdr.de@vger.kernel.org>)
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 15:11:45 +0200
X-Original-To: lists+netfilter-devel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC827316DB
	for <lists+netfilter-devel@lfdr.de>; Thu, 09 Jul 2026 15:11:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ssi.bg header.s=ssi header.b=uFb5HTcL;
	dmarc=pass (policy=reject) header.from=ssi.bg;
	spf=pass (mail.lfdr.de: domain of "netfilter-devel+bounces-13794-lists+netfilter-devel=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netfilter-devel+bounces-13794-lists+netfilter-devel=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2AE7F30361CD
	for <lists+netfilter-devel@lfdr.de>; Thu,  9 Jul 2026 13:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D80826A1C4;
	Thu,  9 Jul 2026 13:07:20 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mx.ssi.bg (mx.ssi.bg [193.238.174.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7714265606;
	Thu,  9 Jul 2026 13:07:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602440; cv=none; b=CCMPPtkXAFAzRSQpC6ljKwr2Cfx9mPbKGfo0i9T3NhQzyE0cu3p70B2uecGNAKb9aY7dNnSmPV12yrPqT9lv+u8sbi5VDMhJgMvgafrZLXSCnKp08GDVpFra+1wy+uDf3nniEgG9yk3eSz7xr8ihY1ylycrUDf1xDCZ9wTESaYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602440; c=relaxed/simple;
	bh=DcdpUurs4X8fkh8egxmf/0LLXh7nERi0BsvIcoCPM3I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=pABc4zpKPWwI4bWZFxUDMb84woZ+oe6tcQF3k81fpmE77yxu68YUh3sFvvlFSEaW6dPkju1gaXn2VW2uKiTZhVLj1bEKr5hwaYuFbvUn7csdD4o0oc3nOhXA9/twq6J9tRte/qfRlz49XqoPI2sEjtRxM8vJOz+VXwe9oPa+gMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ssi.bg; spf=pass smtp.mailfrom=ssi.bg; dkim=pass (4096-bit key) header.d=ssi.bg header.i=@ssi.bg header.b=uFb5HTcL; arc=none smtp.client-ip=193.238.174.39
Received: from mx.ssi.bg (localhost [127.0.0.1])
	by mx.ssi.bg (Potsfix) with ESMTP id 2D3CE20256;
	Thu, 09 Jul 2026 16:07:04 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ssi.bg; h=cc:cc
	:content-type:content-type:date:from:from:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=ssi;
	 bh=AEgbb6Kf815spH1aL9lrNyIHslNsEIK4qHsUXkhzeJU=; b=uFb5HTcLHVoJ
	oImjwRXaq0xujvzQZP74dRX2QNjyvYrRdfKaga8E2K8nvbaHCeKjK9hphE7stcre
	y3sJNu7+KId6DD06WEEHCVv9EUcWy+PpP7bSE543BaFS09NuJGSZIRvOQm78wo34
	5WKSWleqX1FP5DCK5G4OsgHdHj+/UCDfLfYcv05W/9U9SeD8xLJ2KOoIPByBI2X0
	EbBUmALzcd8Z2mGoPzsdv4DxeWRJ94QU4IJY4f/YJrBBzJ9lmLB/Lrf7OUEEzB7c
	ZTWbTas95RQo6ACvyDVM7TvXFDub4eK4kbP0m2Xd1O+Hq7q3ZAt/051xysWKxFRE
	nn6Bfcgq2T++WTrH1t8Atk+uUzMZKnll6sgacOmPHSkJ4TSl7cFdqZ2d76JHV9id
	K7O9xjKipyKQmvFg9dJm3qUOKhrx+oFfT8kWipPkhCU72SSL3dNCosCYGN2i4XbD
	VZBLMSuGRIRocTF8ooz3BIQFuTJ7o/UHASsXmxLQybtDfU5nlamiM+IIP5+d0XAy
	4Ipe+4qIJoGzWNRO6OzpyVktgLHEDVsOCcYocM4Jv0C4he4S/I9F2IIMZW13n+tK
	pjuUKVEmLCRy1Wh2XXVgvFWllrIjb0rbmMDLcXVbW6xtqIiTmsdzUaB24EZzouC6
	GiMrTmbFJw7RSg42yWBcPfteoUDv7VI=
Received: from box.ssi.bg (box.ssi.bg [193.238.174.46])
	by mx.ssi.bg (Potsfix) with ESMTPS;
	Thu, 09 Jul 2026 16:07:04 +0300 (EEST)
Received: from ja.ssi.bg (unknown [213.16.62.126])
	by box.ssi.bg (Potsfix) with ESMTPSA id 3AA376090B;
	Thu,  9 Jul 2026 16:06:53 +0300 (EEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by ja.ssi.bg (8.18.2/8.18.2) with ESMTP id 669D6jCw052928;
	Thu, 9 Jul 2026 16:06:45 +0300
Date: Thu, 9 Jul 2026 16:06:45 +0300 (EEST)
From: Julian Anastasov <ja@ssi.bg>
To: Florian Westphal <fw@strlen.de>
cc: Yizhou Zhao <zhaoyz24@mails.tsinghua.edu.cn>,
        Simon Horman <horms@verge.net.au>, David Ahern <dsahern@kernel.org>,
        Ido Schimmel <idosch@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Pablo Neira Ayuso <pablo@netfilter.org>, Phil Sutter <phil@nwl.cc>,
        Alexander Frolkin <avf@eldamar.org.uk>, netdev@vger.kernel.org,
        lvs-devel@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
        stable@vger.kernel.org, Yuxiang Yang <yangyx22@mails.tsinghua.edu.cn>,
        Ao Wang <wangao@seu.edu.cn>, Xuewei Feng <fengxw06@126.com>,
        Qi Li <qli01@tsinghua.edu.cn>, Ke Xu <xuke@tsinghua.edu.cn>
Subject: Re: [PATCH nf] ipvs: make destination flags atomic
In-Reply-To: <ak-KErd1a0NHGN-D@strlen.de>
Message-ID: <8913381c-1e02-35c7-0ec4-61de5a12fd35@ssi.bg>
References: <20260707085706.96322-1-zhaoyz24@mails.tsinghua.edu.cn> <41c3d792-af7d-5582-5057-ac3df5f7bfd6@ssi.bg> <91509A0C-9E4A-4F0E-A45C-ABD29396067E@mails.tsinghua.edu.cn> <afcdb34c-ec10-de8e-083c-624bcedca90e@ssi.bg> <ak-KErd1a0NHGN-D@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[ssi.bg,reject];
	R_DKIM_ALLOW(-0.20)[ssi.bg:s=ssi];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-13794-lists,netfilter-devel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[mails.tsinghua.edu.cn,verge.net.au,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,netfilter.org,nwl.cc,eldamar.org.uk,vger.kernel.org,seu.edu.cn,126.com,tsinghua.edu.cn];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,ssi.bg:from_mime,ssi.bg:email,ssi.bg:mid,ssi.bg:dkim];
	FORGED_SENDER(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[23];
	FORGED_RECIPIENTS(0.00)[m:fw@strlen.de,m:zhaoyz24@mails.tsinghua.edu.cn,m:horms@verge.net.au,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:pablo@netfilter.org,m:phil@nwl.cc,m:avf@eldamar.org.uk,m:netdev@vger.kernel.org,m:lvs-devel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:netfilter-devel@vger.kernel.org,m:coreteam@netfilter.org,m:stable@vger.kernel.org,m:yangyx22@mails.tsinghua.edu.cn,m:wangao@seu.edu.cn,m:fengxw06@126.com,m:qli01@tsinghua.edu.cn,m:xuke@tsinghua.edu.cn,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[ssi.bg:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ja@ssi.bg,netfilter-devel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netfilter-devel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCC827316DB


	Hello,

On Thu, 9 Jul 2026, Florian Westphal wrote:

> Julian Anastasov <ja@ssi.bg> wrote:
> > 	After looking again at the code, I think we can
> > do it in different way:
> > 
> > - IP_VS_DEST_F_AVAILABLE and IP_VS_DEST_F_OVERLOAD are defined
> > in include/uapi/linux/ip_vs.h but we never export them to user
> > space. So, we are free to change them. We can move them to 
> > include/net/ip_vs.h, see below...
> > 
> > - IP_VS_DEST_F_AVAILABLE is changed only under service_mutex,
> > so we can keep its usage
> > 
> > - IP_VS_DEST_F_OVERLOAD needs different access methods.
> > We can add 'unsigned long flags2;', may be after l_threshold.
> > And to switch to such usage (F_OVERLOAD -> FL_OVERLOAD):
> > 
> > 	- test_bit(IP_VS_DEST_FL_OVERLOAD, &dest->flags2)
> > 	- set_bit(IP_VS_DEST_FL_OVERLOAD, &dest->flags2)
> > 
> > 		Sometimes if (test_bit()) clear_bit() can avoid
> > 		full memory barrier in ip_vs_dest_update_overload()
> > 
> > 	- clear_bit(IP_VS_DEST_FL_OVERLOAD, &dest->flags2)
> > 		test_bit() guard can help here too
> > 
> > 	As there are other races involved, something like
> > this can be a starting point for such change. It tries harder
> > to update the overload flag on dest edit/add but it does not
> > include the proposed bitops:
> >
> > diff --git a/include/net/ip_vs.h b/include/net/ip_vs.h
> > index 49297fec448a..b34631270e24 100644
> 
> Who is supposed to do what?
> 
> I.e., are you going to submit this officially as replacement
> for the v2 of this patch or do you expect the sumbitters of
> this patch to rework their v2 along these lines?

	I can sumbit the ip_vs_dest_update_overload()
part as separate patch which can be followed by patch(es)
that convert the overload flag to bitops.

	I'll wait for comments from Yizhou Zhao, he should
tell me if he is willing to convert the overload flag as
additional patch.

Regards

--
Julian Anastasov <ja@ssi.bg>


