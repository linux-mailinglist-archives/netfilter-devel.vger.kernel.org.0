Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C15EB3FA4A8
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Aug 2021 11:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhH1JTL (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Aug 2021 05:19:11 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49468 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbhH1JTL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Aug 2021 05:19:11 -0400
Received: from netfilter.org (unknown [78.30.35.141])
        by mail.netfilter.org (Postfix) with ESMTPSA id C4C4860089;
        Sat, 28 Aug 2021 11:17:23 +0200 (CEST)
Date:   Sat, 28 Aug 2021 11:18:17 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH libnetfilter_log] build: remove broken code from
 autogen.sh.
Message-ID: <20210828091817.GA13936@salvia>
References: <20210827174143.1094883-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827174143.1094883-1-jeremy@azazel.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Aug 27, 2021 at 06:41:43PM +0100, Jeremy Sowden wrote:
> The `include` function, which is intended to include a copy of the
> kernel's nfnetlink_log.h into the source distribution, has been broken
> since 2012 when the header file was moved from where the function
> expects to find it.  The header is manually sync'ed when necessary.

Applied, thanks.
