Return-Path: <netfilter-devel+bounces-1458-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033A5881735
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 935481F2507F
	for <lists+netfilter-devel@lfdr.de>; Wed, 20 Mar 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D956BB23;
	Wed, 20 Mar 2024 18:09:29 +0000 (UTC)
X-Original-To: netfilter-devel@vger.kernel.org
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFA86A03F
	for <netfilter-devel@vger.kernel.org>; Wed, 20 Mar 2024 18:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.188.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710958169; cv=none; b=iyBzOjCqAlmE1FHNpPW7iHknIfjSpil053jfOEZCi+Pvh6l3B4CEZszJEtrg4uN0veeYxy3NGMnsuylfD1JFsdU+eCA4D+2CkQvdlruoa+3+th5gf84PAc0Zs3N4i0/NPl/iu/a+SwVonSfTU/nEGvW0aq0MWT3Tq1uysvIu4EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710958169; c=relaxed/simple;
	bh=pWiPe36DFJfbepcMP/TFAivIaEz32mETUBUMoPOBaq0=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZoRtb+lQH/icdNTI53AgZfjugtkDRUATIVcmqBl9UvG8bvqU2csahW8uCRe/poF655DD8+219RSda0FOxv1Bdb3z7/eRGLfIuvM7iPsi9TRpxeS5ei1y0z8af8G24c0/VWKs4k9d43WyiMJ8YZDLDdrncYdjO09c380jqdf1zXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org; spf=pass smtp.mailfrom=netfilter.org; arc=none smtp.client-ip=217.70.188.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=netfilter.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netfilter.org
Date: Wed, 20 Mar 2024 19:09:23 +0100
From: Pablo Neira Ayuso <pablo@netfilter.org>
To: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] evaluate: display "Range negative size" error
Message-ID: <ZfsmUykiWOGPARHN@calendula>
References: <20240319192519.206632-1-pablo@netfilter.org>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240319192519.206632-1-pablo@netfilter.org>

On Tue, Mar 19, 2024 at 08:25:19PM +0100, Pablo Neira Ayuso wrote:
> zero length ranges now allowed, therefore, update error message to refer
> to negative ranges which are not possible.

I have pushed it out this patch

