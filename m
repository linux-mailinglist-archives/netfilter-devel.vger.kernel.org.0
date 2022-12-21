Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A1B65343C
	for <lists+netfilter-devel@lfdr.de>; Wed, 21 Dec 2022 17:42:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiLUQlg (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 21 Dec 2022 11:41:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234668AbiLUQld (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 21 Dec 2022 11:41:33 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 58FE123339
        for <netfilter-devel@vger.kernel.org>; Wed, 21 Dec 2022 08:41:20 -0800 (PST)
Date:   Wed, 21 Dec 2022 17:41:17 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Cc:     phil@nwl.cc
Subject: Re: [PATCH nft] owner: Fix potential array out of bounds access
Message-ID: <Y6M3LQU5rXnNw1DX@salvia>
References: <20221221163746.63408-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221221163746.63408-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Wed, Dec 21, 2022 at 05:37:46PM +0100, Pablo Neira Ayuso wrote:
> If the link target length exceeds 'sizeof(tmp)' bytes, readlink() will
> return 'sizeof(tmp)'. Using this value as index is illegal.
> 
> Original update from Phil, for the conntrack-tools tree, which also has
> a copy of this function.

For the record: If this code is generalized, this code is a candidate
for libmnl I think.
