Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EECA33FC2B
	for <lists+netfilter-devel@lfdr.de>; Thu, 18 Mar 2021 01:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229570AbhCRAVu (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Mar 2021 20:21:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbhCRAVZ (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Mar 2021 20:21:25 -0400
Received: from mail.netfilter.org (mail.netfilter.org [IPv6:2001:4b98:dc0:41:216:3eff:fe8c:2bda])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 41B51C06174A
        for <netfilter-devel@vger.kernel.org>; Wed, 17 Mar 2021 17:21:25 -0700 (PDT)
Received: from us.es (unknown [90.77.255.23])
        by mail.netfilter.org (Postfix) with ESMTPSA id AA36D62BA4
        for <netfilter-devel@vger.kernel.org>; Thu, 18 Mar 2021 01:21:21 +0100 (CET)
Date:   Thu, 18 Mar 2021 01:21:22 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf 1/2] netfilter: nftables: missing transaction object
 on flowtable deletion
Message-ID: <20210318002122.GA21014@salvia>
References: <20210317201957.13165-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210317201957.13165-1-pablo@netfilter.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Mar 17, 2021 at 09:19:56PM +0100, Pablo Neira Ayuso wrote:
> The delete flowtable command does not create a transaction if the
> NFTA_FLOWTABLE_HOOK attribute is specified, hence, the flowtable
> is never deleted.

Scratch this.

The existing code is correct. Userspace only includes
NFTA_FLOWTABLE_HOOK when performing an incremental deletion of devices
in the flowtable.
