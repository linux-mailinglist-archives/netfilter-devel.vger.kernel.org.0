Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE689671C20
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Jan 2023 13:34:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjARMd7 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Jan 2023 07:33:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbjARMdG (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Jan 2023 07:33:06 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B15C63A86B
        for <netfilter-devel@vger.kernel.org>; Wed, 18 Jan 2023 03:52:24 -0800 (PST)
Date:   Wed, 18 Jan 2023 12:52:21 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v4] Implement 'reset rule' and 'reset rules' commands
Message-ID: <Y8fddXtJcUfq5RvZ@salvia>
References: <20230117173310.18757-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230117173310.18757-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Jan 17, 2023 at 06:33:10PM +0100, Phil Sutter wrote:
> Reset rule counters and quotas in kernel, i.e. without having to reload
> them. Requires respective kernel patch to support NFT_MSG_GETRULE_RESET
> message type.

LGTM.

As said, there will be time to explore better integration with the
cache to address the EINTR issue and this kernel code can start being
exercise with some userspace.

Thanks.
