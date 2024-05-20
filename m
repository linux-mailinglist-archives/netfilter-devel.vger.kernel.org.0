Return-Path: <netfilter-devel+bounces-2252-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E398C9AC3
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2024 11:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 595301F2115A
	for <lists+netfilter-devel@lfdr.de>; Mon, 20 May 2024 09:54:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17DB547A5D;
	Mon, 20 May 2024 09:54:00 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B136339AC
	for <netfilter-devel@vger.kernel.org>; Mon, 20 May 2024 09:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716198840; cv=none; b=BJLvDwG/kTKkH0Q85hCIgNJJZ5PTKXi69isoL7pVx5Qovx+kJW4vCV8bJf3H7aMNjNqd362NqtPPUOUpQTbAXHUNIhDZm5gzMB7PeF7hJlon+wJt55zpCzcvdtuwhYrcgMdObHtc2rVSfFLr4bJdfrPUm6mzSd7mzoDQ8YvlF34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716198840; c=relaxed/simple;
	bh=0BwzRSg1foVoUDXOdl8wEblzTh6aygyztZVXFRPUx3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XeCJ6276BpIGJiyRsYQJk6JJl6CMQzLrn2UYHWNV+5rU1hdYZQ+JB+EIE8x8IxFnP8ZuOMpRuNlVgezL8qg4p2ohYRqWUSr6KhdpYsrcsUCzT/FXqdOYUQxcDtnMkhwnLCEo+1R249P6qzk7lE+gfLIDpQT9oai7Q9i3DBpjQ3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Mon, 20 May 2024 11:53:53 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Alexander Maltsev <keltar.gw@gmail.com>
Cc: netfilter-devel@vger.kernel.org,
	Jozsef Kadlecsik <kadlec@netfilter.org>
Subject: Re: [PATCH] netfilter: ipset: Add list flush to cancel_gc
Message-ID: <ZksdsVn2atP2Wrzt@calendula>
References: <20240417135141.18288-1-keltar.gw@gmail.com>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240417135141.18288-1-keltar.gw@gmail.com>

On Wed, Apr 17, 2024 at 06:51:41PM +0500, Alexander Maltsev wrote:
> Flushing list in cancel_gc drops references to other lists right away,
> without waiting for RCU to destroy list. Fixes race when referenced
> ipsets can't be destroyed while referring list is scheduled for destroy.

For the record, I have applied this patch to nf.git with this tag:

Fixes: 97f7cf1cd80e ("netfilter: ipset: fix performance regression in swap operation")

I overlook this patch, apologies for the delay.

