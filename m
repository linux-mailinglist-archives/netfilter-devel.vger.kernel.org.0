Return-Path: <netfilter-devel+bounces-4728-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 936C89B0FAB
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2024 22:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C42D11C213FA
	for <lists+netfilter-devel@lfdr.de>; Fri, 25 Oct 2024 20:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1144A20D516;
	Fri, 25 Oct 2024 20:18:25 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from www4.stratanet.com (www4.stratanet.com [67.213.225.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A77DC17C9E8
	for <netfilter-devel@vger.kernel.org>; Fri, 25 Oct 2024 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.213.225.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887505; cv=none; b=cI3FGbdZaCXqALRUM9EjM+7GaB28zQOYwaIz2LS685qwvd9sQOImis25zyvFNdA18DnO+XtSd3t1sTB3DylW6pF0OHgLd3U11Qf+XGGgqgeqQFm4ggi3H2WN0V0dPKXKZhXCQGgaYvhZKMdDKZWf8puUri/O4o/Fs/qXi7htjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887505; c=relaxed/simple;
	bh=OD8n3cTa2GC73iDchoI0BLzBaopgC/+gShrumD9KsM4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DjDAw3uVT2P+fhvb9XdnRQsDEbj0AAWnm0flK8BRL4DQdky8XYbWSTR+SCV4zH8RtvONtgZ/jx7CxCtyQLzAywKh3lwoBMywInaDvsHpJ3R6R5HEt6/Eq6v346J3jvsZINBJxyANZXiVuCmHM4Jd1313wsqyrMKUoAgcULWuKSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cataumetca.org; spf=fail smtp.mailfrom=cataumetca.org; arc=none smtp.client-ip=67.213.225.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cataumetca.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=cataumetca.org
Received: from ec2-35-93-161-92.us-west-2.compute.amazonaws.com ([35.93.161.92]:52675)
	by www4.stratanet.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98)
	(envelope-from <info@cataumetca.org>)
	id 1t4QlJ-0000000DOzK-3kR9
	for netfilter-devel@vger.kernel.org;
	Fri, 25 Oct 2024 14:18:22 -0600
From: Chan Moo Bahk <info@cataumetca.org>
To: netfilter-devel@vger.kernel.org
Subject: =?UTF-8?B?QlVTSU5FU1PCoExBVU5DSCA=?=
Date: 25 Oct 2024 20:18:21 +0000
Message-ID: <20241025201820.AE0B551DC8DBC4CC@cataumetca.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - www4.stratanet.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - cataumetca.org
X-Get-Message-Sender-Via: www4.stratanet.com: authenticated_id: northeasternofficesupply@northeasternofficesupply.com
X-Authenticated-Sender: www4.stratanet.com: northeasternofficesupply@northeasternofficesupply.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 

Good day sir/madam,

I am Chan Moo Bahk. I have a lucrative business proposal deal I'd=20
like to discuss with you. I am representing a group of=20
prospective investors in the USA, Europe and Asian continent.

We are seeking a professional with whom we can be involved in=20
partnership overseas, who also has the ability to manage an=20
investment portfolio in your country. If you indicate interest,=20
send a reply only via ChanMooBahk@mail.com for more details so=20
you can have a better knowledge of who you are dealing with.

I look forward to your response if this appeals to you.

Regards

Chan Moo Bahk.
ChanMooBahk@mail.com 

