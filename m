Return-Path: <netfilter-devel+bounces-9360-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B805BFC972
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Oct 2025 16:38:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A78874F3E04
	for <lists+netfilter-devel@lfdr.de>; Wed, 22 Oct 2025 14:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DD1F20C023;
	Wed, 22 Oct 2025 14:34:32 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C4E288502
	for <netfilter-devel@vger.kernel.org>; Wed, 22 Oct 2025 14:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761143672; cv=none; b=RbLPKo/MMbubCz3oxuboMWy3R24G9HkNH7ihStLtCyG92Jsw5GkP5eg85AT3nx2gWaxhTFjws1UsX3bSIx9T6y4v5SWkEqyUqL50FW9JNKSLs3wpP7hsjAeI+UCEQDC6BCORBtD0wRLVXseiv1FjruxZsoWHk0uZbENmzvTCMOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761143672; c=relaxed/simple;
	bh=x3zik6Yh9fL1sTyEXBbYC3AW3Kj4l9hnuvO9uO5SX5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mJJMkBMCAv07HUSdQ8xXsyHvxzX1lFhZ9vvVO3ayqqM8gIDVLBxqKf/3LSlFsy7cS7i2pzyaad11ispa4aDhnSsWirV9JYr07U9Oiw5DhLynvA4VzbEByXOVpoSH1kFeYjFIOfN1Cz5BNJmIYpXeWdUekg45zJQBENowLRF4X9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 834546031F; Wed, 22 Oct 2025 16:34:27 +0200 (CEST)
Date: Wed, 22 Oct 2025 16:34:27 +0200
From: Florian Westphal <fw@strlen.de>
To: Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>
Cc: netfilter-devel@vger.kernel.org, pablo@netfilter.org
Subject: Re: [PATCH v4 5/5] doc: minor improvements the `reject` statement
Message-ID: <aPjrc9NQ7wKmCboT@strlen.de>
References: <6bb455009ebd3a2fe17581dfa74addc9186f33ea.camel@scientia.org>
 <20251020235130.361377-1-mail@christoph.anton.mitterer.name>
 <20251020235130.361377-6-mail@christoph.anton.mitterer.name>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251020235130.361377-6-mail@christoph.anton.mitterer.name>

Christoph Anton Mitterer <mail@christoph.anton.mitterer.name> wrote:
> +A reject statement tries to send back an error packet in response to the matched
> +packet and then interally issues a *drop* verdict.
> +It’s thus a terminating statement with all consequences of the latter (see
> +<<OVERALL EVALUATION OF THE RULESET>> respectively <<VERDICT STATEMENTS>>).

This lacks anchors, also in other references that get added, rendered
man page has:

".. the latter (see ??? respectively ???)."

