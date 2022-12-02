Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B04640730
	for <lists+netfilter-devel@lfdr.de>; Fri,  2 Dec 2022 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbiLBMyb (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 2 Dec 2022 07:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232971AbiLBMy3 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 2 Dec 2022 07:54:29 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 08033CCFF2
        for <netfilter-devel@vger.kernel.org>; Fri,  2 Dec 2022 04:54:27 -0800 (PST)
Date:   Fri, 2 Dec 2022 13:54:24 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Alex Forster <aforster@cloudflare.com>
Cc:     netfilter-devel@vger.kernel.org, Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH] json: fix 'add flowtable' command
Message-ID: <Y4n1gEAQXSyfBauf@salvia>
References: <20221202033501.48129-1-aforster@cloudflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221202033501.48129-1-aforster@cloudflare.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Dec 01, 2022 at 09:35:01PM -0600, Alex Forster wrote:
> In `json_parse_cmd_add_flowtable`, the format arguments passed to `json_unpack` are incorrect: the object key name ("dev") is not provided.

Applied to nftables, thanks
