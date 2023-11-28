Return-Path: <netfilter-devel+bounces-94-lists+netfilter-devel=lfdr.de@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 779697FB99B
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Nov 2023 12:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A82871C2118F
	for <lists+netfilter-devel@lfdr.de>; Tue, 28 Nov 2023 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96054F61C;
	Tue, 28 Nov 2023 11:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netfilter-devel@vger.kernel.org
Received: from orbyte.nwl.cc (orbyte.nwl.cc [IPv6:2001:41d0:e:133a::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E6BD5D
	for <netfilter-devel@vger.kernel.org>; Tue, 28 Nov 2023 03:46:23 -0800 (PST)
Received: from n0-1 by orbyte.nwl.cc with local (Exim 4.94.2)
	(envelope-from <n0-1@orbyte.nwl.cc>)
	id 1r7wXl-0003Om-0g; Tue, 28 Nov 2023 12:46:21 +0100
Date: Tue, 28 Nov 2023 12:46:21 +0100
From: Phil Sutter <phil@nwl.cc>
To: Jan Engelhardt <jengelh@inai.de>
Cc: netfilter-devel@vger.kernel.org
Subject: Re: [PATCH] man: proper roff encoding for ~ and ^
Message-ID: <ZWXTDX1nuwSc1d0t@orbyte.nwl.cc>
Mail-Followup-To: Phil Sutter <phil@nwl.cc>,
	Jan Engelhardt <jengelh@inai.de>, netfilter-devel@vger.kernel.org
References: <20231125161326.77308-1-jengelh@inai.de>
Precedence: bulk
X-Mailing-List: netfilter-devel@vger.kernel.org
List-Id: <netfilter-devel.vger.kernel.org>
List-Subscribe: <mailto:netfilter-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netfilter-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231125161326.77308-1-jengelh@inai.de>

On Sat, Nov 25, 2023 at 05:12:50PM +0100, Jan Engelhardt wrote:
> Fixes: v1.8.10-28-g4b0c168a
> Signed-off-by: Jan Engelhardt <jengelh@inai.de>
> ---
> I thought I had read the groff_char manual, but perhaps too hastily.

Indeed, and nobody apparently tested the results - at least on my
system, neither \~ nor \^ produce a visible character with either man or
html output (produced by mandoc). I can't test PDF right now for some
font problem.

BTW: HTML output seems identical for both the replacements in this patch
and the plain unquoted characters. Even though groff_char claims
otherwise.

Cheers, Phil

