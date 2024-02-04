Return-Path: <netfilter-devel+bounces-874-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45FD78491F8
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Feb 2024 01:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2C952827C0
	for <lists+netfilter-devel@lfdr.de>; Mon,  5 Feb 2024 00:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05C4818E;
	Mon,  5 Feb 2024 00:05:01 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail-108-mta195.mxroute.com (mail-108-mta195.mxroute.com [136.175.108.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905E57F
	for <netfilter-devel@vger.kernel.org>; Mon,  5 Feb 2024 00:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707091500; cv=none; b=SG6NGpu14TEgVnpiKHqe1TeaUUN90EYcpDsOHsvtt1JgonCEjaE6osj3xEAIzZcl/iQZ8OxsQ48uET0MWA/iHepug8VzOU5JnyzZBNeuU1vZ23sj0M2cBGwoHdIIxUV83hR6YMIrLrrJeGDFh6DJGUafavSEkb6TYbbCkuWxIBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707091500; c=relaxed/simple;
	bh=EaoRk9GSXpc8Gyjy0jGeG/oCseOAL4yhyAQyqGmCIXU=;
	h=Date:From:To:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWpqZXCMf3xbuvZQ8HCYJdyT4/EHwNIXcrlRkQnwizjgFbNEwY21JmLvgzJ6YWB3p0VmHi6TSxyk3hJ4xz7Bl3Y5JkmyRIDu9Do7sBRUBh0BIEG16dC0uDI+5YyMPqLk403Drx0L4iwma/LaaD8u7Y7rnlHBrJQdXVpXpoMzk5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net; spf=pass smtp.mailfrom=romanrm.net; arc=none smtp.client-ip=136.175.108.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=romanrm.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=romanrm.net
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta195.mxroute.com (ZoneMTA) with ESMTPSA id 18d769049640003727.001
 for <netfilter-devel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Sun, 04 Feb 2024 23:59:43 +0000
X-Zone-Loop: 04aa2378a6ad1251ac5ac5c87e6ef284d20ecc7d78e6
Date: Mon, 5 Feb 2024 04:59:22 +0500
From: Roman Mamedov <rm@romanrm.net>
To: netfilter-devel@vger.kernel.org
Subject: Re: iptables: considers incomplete rule in -C and finds an
 erroneous match
Message-ID: <20240205045922.78b48ebc@nvm>
In-Reply-To: <20240205044519.45334f8e@nvm>
References: <20240205044519.45334f8e@nvm>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: rm@romanrm.net

On Mon, 5 Feb 2024 04:45:19 +0500
Roman Mamedov <rm@romanrm.net> wrote:

>   # ip6tables-save | grep 80,443
>   -A INPUT -s fd39::/16 -p tcp -m multiport --dports 80,443 -j ACCEPT

Actually the 2nd rule doesn't matter at all, it just returns success (rule
exists) on anything.

  # ip6tables -C INPUT -p udp --dport 12345 -j ACCEPT && echo Exists
  Exists

  # ip6tables-save | grep 12345
  #

-- 
With respect,
Roman

