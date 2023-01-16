Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29D366BDDA
	for <lists+netfilter-devel@lfdr.de>; Mon, 16 Jan 2023 13:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjAPMaw (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 16 Jan 2023 07:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjAPMaq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:30:46 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E65A1E1DF
        for <netfilter-devel@vger.kernel.org>; Mon, 16 Jan 2023 04:30:45 -0800 (PST)
Date:   Mon, 16 Jan 2023 13:30:42 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] Implement 'reset rule' and 'reset rules' commands
Message-ID: <Y8VDcq8UXg+5GD+F@salvia>
References: <20230112162342.2986-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230112162342.2986-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Jan 12, 2023 at 05:23:42PM +0100, Phil Sutter wrote:
> Reset rule counters and quotas in kernel, i.e. without having to reload
> them. Requires respective kernel patch to support NFT_MSG_GETRULE_RESET
> message type.

Only thing to mention: This adds a new rule_cache_dump() call, this
was consolidated on top of the cache infrastructure, to have a single
spot in the code to fetch kernel objects via netlink. This triggers to
netlink dumps, one to populate the cache and another for the reset,
right?

Apart from that, patch LGTM.
