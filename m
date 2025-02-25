Return-Path: <netfilter-devel+bounces-6094-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 492F8A450D8
	for <lists+netfilter-devel@lfdr.de>; Wed, 26 Feb 2025 00:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBD7F19C176D
	for <lists+netfilter-devel@lfdr.de>; Tue, 25 Feb 2025 23:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AA6235374;
	Tue, 25 Feb 2025 23:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="NwkKPOHY";
	dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b="NwkKPOHY"
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.190.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D64818C34B
	for <netfilter-devel@vger.kernel.org>; Tue, 25 Feb 2025 23:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.190.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740525103; cv=none; b=N09BQ/e0FQkPbwzfnZnQQmom1leR7HJ/bJvYlA0iovqNZ8EToe808SJJL/x6UhuH99SjGf+cTQVgZTZ96jE7fbGzfSptdrfxCyoW5QBq9HqNpxt6+mx6792id2jJxmEH7Kn4cpJYTuPuAIsQcVS7pEGCiZKnIyw/1Nxqr04MVmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740525103; c=relaxed/simple;
	bh=v4ooYapeOxbaIaw3GD8k3XNvX+OQMiiDUxOzAwuTJeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sM+ZjsoYfvIbKDSNiOoT/k4kCLAyUOdogwAEUB6W+btoZobpHdTIghThdEDzaUYKAiEUW5EF6c5bbu8v1cql0Ykz+xFstyT6xQtTemTaducKy/+xz0mHTgl2vsMa5++80AfxAkuxTq2oy8dzVRZzKTaYsLkmezi6Q3VMqBd70Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=NwkKPOHY; dkim=pass (2048-bit key) header.d=netfilter.org header.i=@netfilter.org header.b=NwkKPOHY; arc=none smtp.client-ip=217.70.190.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Received: by mail.netfilter.org (Postfix, from userid 109)
	id E3A4260296; Wed, 26 Feb 2025 00:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1740525096;
	bh=sC6TiuOr1PIzmV+AgUqK5uxgfWKt9RulfgFwR/M8LMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwkKPOHYG4qQ7hk5GUgxgAevAqfU0veho4uq5aiBTDx85+NV98D13F+zaHENhz1TN
	 z5/Zd+yiuuGy5vjKbwuv98eSIcOVlTmh412lG/kOV5W8d8kv9kCXQejTomQ2n5G9j5
	 QAXj5kvgf5JrxlGELJbZ18BV54wCjbbLkWGQnKovSNfzgl/Z2dXhEvMDr5Axnu/oDQ
	 GLkOUKiiPCc7CEhV/KHnoKlVhaUPUoyIhncLDW+9BFUn0ZFlSLvpsmIkQaTgonKksJ
	 ZXIH7pnb0GIbw8mt2Q5FjGzboZC0w9iM3W/Z6yN0M63xI2PK+jJEz3+9QjbLUN6KE/
	 y3pel0XdtZfSg==
X-Spam-Level: 
Received: from netfilter.org (mail-agni [217.70.190.124])
	by mail.netfilter.org (Postfix) with ESMTPSA id 6D6A360296;
	Wed, 26 Feb 2025 00:11:36 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netfilter.org;
	s=2025; t=1740525096;
	bh=sC6TiuOr1PIzmV+AgUqK5uxgfWKt9RulfgFwR/M8LMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NwkKPOHYG4qQ7hk5GUgxgAevAqfU0veho4uq5aiBTDx85+NV98D13F+zaHENhz1TN
	 z5/Zd+yiuuGy5vjKbwuv98eSIcOVlTmh412lG/kOV5W8d8kv9kCXQejTomQ2n5G9j5
	 QAXj5kvgf5JrxlGELJbZ18BV54wCjbbLkWGQnKovSNfzgl/Z2dXhEvMDr5Axnu/oDQ
	 GLkOUKiiPCc7CEhV/KHnoKlVhaUPUoyIhncLDW+9BFUn0ZFlSLvpsmIkQaTgonKksJ
	 ZXIH7pnb0GIbw8mt2Q5FjGzboZC0w9iM3W/Z6yN0M63xI2PK+jJEz3+9QjbLUN6KE/
	 y3pel0XdtZfSg==
Date: Wed, 26 Feb 2025 00:11:33 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: Florian Westphal <fw@strlen.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] payload: remove double-store
Message-ID: <Z75OJfARMmx3cepx@calendula>
References: <20250225203334.28465-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250225203334.28465-1-fw@strlen.de>

On Tue, Feb 25, 2025 at 09:33:30PM +0100, Florian Westphal wrote:
> This assignment was duplicated.
> 
> Signed-off-by: Florian Westphal <fw@strlen.de>

Reviewed-by: Pablo Neira Ayuso <pablo@netfilter.org>

Thanks.

