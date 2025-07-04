Return-Path: <netfilter-devel+bounces-7715-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E53AF898B
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Jul 2025 09:32:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B356580DD3
	for <lists+netfilter-devel@lfdr.de>; Fri,  4 Jul 2025 07:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD5A27F758;
	Fri,  4 Jul 2025 07:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WVBZwoPW";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="WVBZwoPW"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D0E271440
	for <netfilter-devel@vger.kernel.org>; Fri,  4 Jul 2025 07:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751614261; cv=none; b=oZ/X3Kh0tqYrENUGfJ+PWn5EbQjVYcGeaUI1FAkt0DG+Hh0e2Eho/w0wPp9QGEobwNt136rXIi4s38ElkSbPv2erZBIrCkrxgYSJS0gKXMqekv2tdQiaBCqL6GKEcdUgg+nCXbwszntWTb7iexXr52eIaEnokOJx75vkThlz2hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751614261; c=relaxed/simple;
	bh=co6AYesqLzmVu5JMlaJ6b78V6uSOIJgk+NlcOTFjGZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zk9P5RHJr26ODCi2yj/q6SVNPnV6F3oXRvRuw1to6Ff2w7s811gD7jp4V+CVOVc3Qq2P8oVoreicj2X7QJXWRgkUEvlbJ+BHvpwMNgDFN8b6+P4/bFXhcWhJUv5kGrYuMvLlWTDGuGdpDBXBf4iE6Xw/UrjetVO5Jdl2B8JJ3Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WVBZwoPW; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=WVBZwoPW; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id 9EE7A60262; Fri,  4 Jul 2025 09:30:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1751614254;
	bh=m+RiX8GthdRw5NbL+f0S1ZRl5p+tMRJfxpfHK+tv0+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVBZwoPWPE3VTyLMMOHQ36UCEwfSCJCsu6pfoIhXxqNSBrp/1VR2UYoSG/c94H6zQ
	 2yMtUBfXDBTBkySqX7ait0gD9l0QzIbL0VfV+csIzkyUJKDKB323Xs9Ypk8xKNNHKP
	 DENuUpEUXMVcO5ZcH0md15T+CjDpe/NaIKLYoEViu6PwpueGFr6tb/fenMvyhodNb2
	 QPvlXePMeb+yLcYpcwn4NDSSXNGBcVXRTVWAg0n9AvHPANxLf0XoSnNk75gJv11gJN
	 +YmmX7JtgkZa+0loOHkW7DyXZrXL1JSXgH3pVxTtWGz9DORtO1FBpPAUwcf3iBrZpK
	 O/pUKxg1GwUGg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id E137B60262;
	Fri,  4 Jul 2025 09:30:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1751614254;
	bh=m+RiX8GthdRw5NbL+f0S1ZRl5p+tMRJfxpfHK+tv0+U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WVBZwoPWPE3VTyLMMOHQ36UCEwfSCJCsu6pfoIhXxqNSBrp/1VR2UYoSG/c94H6zQ
	 2yMtUBfXDBTBkySqX7ait0gD9l0QzIbL0VfV+csIzkyUJKDKB323Xs9Ypk8xKNNHKP
	 DENuUpEUXMVcO5ZcH0md15T+CjDpe/NaIKLYoEViu6PwpueGFr6tb/fenMvyhodNb2
	 QPvlXePMeb+yLcYpcwn4NDSSXNGBcVXRTVWAg0n9AvHPANxLf0XoSnNk75gJv11gJN
	 +YmmX7JtgkZa+0loOHkW7DyXZrXL1JSXgH3pVxTtWGz9DORtO1FBpPAUwcf3iBrZpK
	 O/pUKxg1GwUGg==
Date: Fri, 4 Jul 2025 09:30:51 +0200
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnftnl v2] trace: add support for TRACE_CT information
Message-ID: <aGeDK2hr7eFR7VT7@calendula>
References: <20250522135119.30469-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250522135119.30469-1-fw@strlen.de>

On Thu, May 22, 2025 at 03:51:15PM +0200, Florian Westphal wrote:
> Decode direction/id/state/status information.
> This will be used by 'nftables monitor trace' to print a packets
> conntrack state.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

