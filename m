Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F128943D7EA
	for <lists+netfilter-devel@lfdr.de>; Thu, 28 Oct 2021 02:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbhJ1AHC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 27 Oct 2021 20:07:02 -0400
Received: from mail.netfilter.org ([217.70.188.207]:49496 "EHLO
        mail.netfilter.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhJ1AHB (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 27 Oct 2021 20:07:01 -0400
Received: from netfilter.org (unknown [78.30.32.163])
        by mail.netfilter.org (Postfix) with ESMTPSA id 8BC8F63586;
        Thu, 28 Oct 2021 02:02:45 +0200 (CEST)
Date:   Thu, 28 Oct 2021 02:04:29 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Lukas Wunner <lukas@wunner.de>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nft] src: Support netdev egress hook
Message-ID: <YXnpDc1hPBgKd7xb@salvia>
References: <20211027101715.47905-1-pablo@netfilter.org>
 <20211027121442.GA20375@wunner.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211027121442.GA20375@wunner.de>
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Oct 27, 2021 at 02:14:42PM +0200, Lukas Wunner wrote:
> On Wed, Oct 27, 2021 at 12:17:15PM +0200, Pablo Neira Ayuso wrote:
> > Hi Lukas,
> > 
> > This is the rebase I'm using here locally for testing, let me know if
> > you have more pending updates on your side.
> 
> I'm using the attached two patches.

Both patches are applied, thanks.
