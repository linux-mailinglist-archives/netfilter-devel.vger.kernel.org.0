Return-Path: <netfilter-devel+bounces-9519-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EB402C1A22C
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Oct 2025 13:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 4654A34B282
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Oct 2025 12:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 286B733A012;
	Wed, 29 Oct 2025 12:07:50 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from a3.inai.de (a3.inai.de [144.76.212.145])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510AE337B92
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Oct 2025 12:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.212.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761739670; cv=none; b=GqjAx6pk7BFc+nkh8pOGuuqvNFRrUUIdukWycYdik0cm2wPMGaHUk1dD3KFCGhQk5Dw73yZwftNwDEGJVNEkwAxmSAlg3/CIP22RvlF/9y8wbQyGhe65Oxyf0jC3/eoeMV0ZdJe7XtZVUBuwOqYjbCF/9R2D61WuIV3GcNPrbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761739670; c=relaxed/simple;
	bh=hhq5UB2i3T53ulv++BQYKe6Xle8ZsC8yPXtKBfauh1I=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=BkAQWCwGswzyzy67/o/nUqb2oe4MYBaGHNC9rDMm1fBeN3jpd3LmZ30dTzwTpKLtg4LpYL2a2zY8zABSGeNMtxfwJ55s5UHSXJxpgwKRL4TpWFF6lH7PXZbGsBRF4ct48E9nOO7H0HD6K2Dmr94ltyDgsz1Sh7uwGHZwEw1ke48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de; spf=pass smtp.mailfrom=inai.de; arc=none smtp.client-ip=144.76.212.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inai.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inai.de
Received: by a3.inai.de (Postfix, from userid 25121)
	id BB2841003BBCE9; Wed, 29 Oct 2025 13:07:42 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by a3.inai.de (Postfix) with ESMTP id B92C21100F2BD1;
	Wed, 29 Oct 2025 13:07:42 +0100 (CET)
Date: Wed, 29 Oct 2025 13:07:42 +0100 (CET)
From: Jan Engelhardt <ej@inai.de>
To: Florian Westphal <fw@strlen.de>
cc: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>, 
    netfilter-devel@vger.kernel.org
Subject: Re: [PATCH 0/8] improve systemd service
In-Reply-To: <aQH9SaAdc8fDKjcc@strlen.de>
Message-ID: <466nr70r-948o-n8pn-q82p-8sp58720qp05@vanv.qr>
References: <20251024023513.1000918-1-mail@christoph.anton.mitterer.name> <aQDwcsK0RKsrtVop@strlen.de> <b66cb7d6e998dcb76cee90694d4632c6d7122153.camel@christoph.anton.mitterer.name> <aQH9SaAdc8fDKjcc@strlen.de>
User-Agent: Alpine 2.26 (LSU 649 2022-06-02)
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII


On Wednesday 2025-10-29 12:40, Florian Westphal wrote:
>> 
>> Hope that I don't negatively affect anyone's use case for this, but if
>> the file isn't meant to be maintained, shouldn't it then rather be
>> dropped?
>
>If this thing needs constant changes then yes, absolutely.

If that were the case, we should drop Linux like a hot potato.
Constantly changing!

