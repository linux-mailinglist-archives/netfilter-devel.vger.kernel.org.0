Return-Path: <netfilter-devel+bounces-8208-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80A66B1D5E5
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Aug 2025 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 409183B468C
	for <lists+netfilter-devel@lfdr.de>; Thu,  7 Aug 2025 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F21257AF0;
	Thu,  7 Aug 2025 10:38:48 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62580288A8
	for <netfilter-devel@vger.kernel.org>; Thu,  7 Aug 2025 10:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754563128; cv=none; b=LH4pU3FKlRLPsaFg8OstV9Sir/aEl5Q5QcMX90IA6XqYM0dZrLouwzrC7IbjZf6USct93NLerYUMne7ElK0hMTsxxmB1vRB3Kn8a+K7G71cPj1U6fYvAtUk2qpUT3VD2csdKs4fkANLBBJPztImMdGbeUpgkEVYk7P+whOlE9xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754563128; c=relaxed/simple;
	bh=mANXulbeLJ5MbBCkeOW60FFPAd8U+GF8xln+sgD0ibA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U3BYMfHL7anCxyy+MM2Uw748X3QE7aYFgfrgfuds4nudjbBKLqMlzEZbloUC5yntULw4qVscasuo1GfErCBnZ8lV+RSx6wzVriYs+imWQ/JvnWK59qAddy3OvIq6lXbpEqUBTvSbNT6b0k/DHKUvqtugZbMrf/P99qmsjxKX3kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B604F6061F; Thu,  7 Aug 2025 12:38:43 +0200 (CEST)
Date: Thu, 7 Aug 2025 12:38:43 +0200
From: Florian Westphal <fw@strlen.de>
To: Phil Sutter <phil@nwl.cc>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	netfilter-devel@vger.kernel.org, Yi Chen <yiche@redhat.com>
Subject: Re: [nft PATCH] tests: shell: Fix packetpath/rate_limit for old socat
Message-ID: <aJSCM58M4KUlq0vc@strlen.de>
References: <20250806143814.4003-1-phil@nwl.cc>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250806143814.4003-1-phil@nwl.cc>

Phil Sutter <phil@nwl.cc> wrote:
> The test would spuriously fail on RHEL9 due to the penultimate socat
> call exiting 0 despite the connection being expected to fail. Florian
> writes:

Thanks for sending a patch.  Please push it out.

