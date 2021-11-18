Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D911D4565E6
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Nov 2021 23:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232568AbhKRWzA (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 18 Nov 2021 17:55:00 -0500
Received: from mail.netfilter.org ([217.70.188.207]:59128 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231526AbhKRWzA (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 18 Nov 2021 17:55:00 -0500
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 652C9648FA;
        Thu, 18 Nov 2021 23:49:52 +0100 (CET)
Date:   Thu, 18 Nov 2021 23:51:54 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [libnetfilter_log PATCH] build: fix `--disable-static`
Message-ID: <YZbZCr8j9O1VunMz@salvia>
References: <20211118224955.1444646-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211118224955.1444646-1-jeremy@azazel.net>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Nov 18, 2021 at 10:49:55PM +0000, Jeremy Sowden wrote:
> The `LT_INIT` argument should be `disable-static`.  Fix it.

Applied, thanks.
