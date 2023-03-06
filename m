Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6948D6ABDE1
	for <lists+netfilter-devel@lfdr.de>; Mon,  6 Mar 2023 12:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbjCFLLY (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Mon, 6 Mar 2023 06:11:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbjCFLLH (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Mon, 6 Mar 2023 06:11:07 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3605626860
        for <netfilter-devel@vger.kernel.org>; Mon,  6 Mar 2023 03:10:24 -0800 (PST)
Date:   Mon, 6 Mar 2023 12:10:14 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ivan Delalande <colona@arista.com>
Cc:     fw@strlen.de, kadlec@netfilter.org, netfilter-devel@vger.kernel.org
Subject: Re: [PATCH v2] netfilter: ctnetlink: revert to dumping mark
 regardless of event type
Message-ID: <ZAXKFraAPLgeybEo@salvia>
References: <20230303014831.GA374206@visor>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230303014831.GA374206@visor>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Thu, Mar 02, 2023 at 05:48:31PM -0800, Ivan Delalande wrote:
> It seems that change was unintentional, we have userspace code that
> needs the mark while listening for events like REPLY, DESTROY, etc.
> Also include 0-marks in requested dumps, as they were before that fix.

Applied, thanks
