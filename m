Return-Path: <netfilter-devel+bounces-9521-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C6BC1AA9C
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Oct 2025 14:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D2A3561A27
	for <lists+netfilter-devel@lfdr.de>; Wed, 29 Oct 2025 13:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70EBF262FFC;
	Wed, 29 Oct 2025 12:47:40 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82F23C513
	for <netfilter-devel@vger.kernel.org>; Wed, 29 Oct 2025 12:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761742060; cv=none; b=BDmGmnPSllTqxpPHEadpAnJa5J1qsptD84L8qPxbmEZFjKKeCrAXaDa3tp9bNHAjjibDauXZ3K0oTlPMGu2GaaxCfL0efaUAT5dvlEHsTUHQyzfGAl3UGDrsxDbBQ17IEN3RYuvdAKCIhmuFxWJd6eEED2aHwrGP7VJUPObJ9mA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761742060; c=relaxed/simple;
	bh=xT7WM98PqsnMe/rgryspXXrtcI7WDptXTvSKBTBORFo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ac0GNQe/wpWWnDZqnTT/DRykKR73Gr8Mol2o7Bljbx7bfF71OHRQbd2RXKrEbphIJfXhXga+U6d1E8MvW+SYE1SaZf7Aym0csDSY3MNTZlgDBdLKdZPcmWyYg3MQAHSbeLMjZpzp2oUue4Hphh8tngP4leaHURmv9L1As7mcUmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 2AA26602E2; Wed, 29 Oct 2025 13:47:36 +0100 (CET)
Date: Wed, 29 Oct 2025 13:47:35 +0100
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH 27/28] utils: Cover for missing newline after BUG()
 messages
Message-ID: <aQIM530vaoXIEr89@strlen.de>
References: <20251023161417.13228-1-phil@nwl.cc>
 <20251023161417.13228-28-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251023161417.13228-28-phil@nwl.cc>

Phil Sutter <phil@nwl.cc> wrote:
> Relieve callers from having to suffix their messages with a newline
> escape sequence, have the macro append it to the format string instead.
> 
> This is mostly a fix for (the many) calls to BUG() without a newline
> suffix but causes an extra new line in (equally many) others. Fixing
> them is subject to followup patch.

Would you mind rebaseing this patch and the next one?
No need to resend, just push these two out.

