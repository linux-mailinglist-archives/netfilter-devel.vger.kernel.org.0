Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC92B6661CE
	for <lists+netfilter-devel@lfdr.de>; Wed, 11 Jan 2023 18:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235237AbjAKR3r (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 11 Jan 2023 12:29:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239836AbjAKR3S (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 11 Jan 2023 12:29:18 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F257A392E2
        for <netfilter-devel@vger.kernel.org>; Wed, 11 Jan 2023 09:27:24 -0800 (PST)
Date:   Wed, 11 Jan 2023 18:27:21 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     William Blough <devel@blough.us>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH libnetfilter_conntrack 1/1] conntrack: Allow setting of
 netlink buffer size
Message-ID: <Y77xebdD+v9ZjEyb@salvia>
References: <Y7h1o0H+dvAz1vtZ@prometheus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y7h1o0H+dvAz1vtZ@prometheus>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 06, 2023 at 02:25:23PM -0500, William Blough wrote:
> ENOBUFS is returned in the case that the nfnetlink socket buffer is
> exhausted.  The function nfnl_rcvbufsize is provided by libnfnetlink
> to set the buffer size in order to handle this error, however
> libnetfilter_conntrack does not expose this function for the underlying
> netlink socket.
> 
> Add nfct_rcvbufsiz function to allow setting of buffer size for netlink
> socket.

Thanks for your patch.

There is already nfct_fd() and you can use setsockopt() on it.
