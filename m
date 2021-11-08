Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3D0F447D4B
	for <lists+netfilter-devel@lfdr.de>; Mon,  8 Nov 2021 11:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbhKHKLj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 8 Nov 2021 05:11:39 -0500
Received: from mail.netfilter.org ([217.70.188.207]:46698 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235894AbhKHKLi (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 8 Nov 2021 05:11:38 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id C0B9B6063C;
        Mon,  8 Nov 2021 11:06:55 +0100 (CET)
Date:   Mon, 8 Nov 2021 11:08:49 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [ulogd2 PATCH v2 00/27] Compiler Warning Fixes
Message-ID: <YYj3MZu+JG0G9zhj@salvia>
References: <20211106164953.130024-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211106164953.130024-1-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Sat, Nov 06, 2021 at 04:49:26PM +0000, Jeremy Sowden wrote:
> This patch-set fixes all the warnings reported by gcc 11.
> 
> Patch 1 adds the `format` GCC attribute to ulogd_log.
> Patches 2-5 fix the format errors revealed by the patch 1.
> Patches 6-8 fix fall-through warnings.
> Patches 9-10 are flow-control improvements related to patch 8.
> Patch 11 replaces malloc+memset with calloc.
> Patches 12-14 fix string-truncation warnings.
> Patch 15 fixes a possible unaligned pointer access.
> Patch 16 fixes DBI deprecation warnings.
> Patches 17-20 fix more truncation warnings.
> Patch 21 adds error-checking to sqlite SQL preparation.
> Patches 22-26 fix more truncation and format warnings.
> Patches 27 removes some superfluous preprocessor macros.

Please, add a description to your patches. Thanks.
