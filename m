Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A72F6B3E42
	for <lists+netfilter-devel@lfdr.de>; Fri, 10 Mar 2023 12:44:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230248AbjCJLoz (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 10 Mar 2023 06:44:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbjCJLoy (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 10 Mar 2023 06:44:54 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2916D5DEC9
        for <netfilter-devel@vger.kernel.org>; Fri, 10 Mar 2023 03:44:53 -0800 (PST)
Date:   Fri, 10 Mar 2023 12:44:50 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Phil Sutter <phil@nwl.cc>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [nft PATCH v2] Reject invalid chain priority values in user space
Message-ID: <ZAsYMlg8TyMcgVP6@salvia>
References: <20230310112348.32373-1-phil@nwl.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230310112348.32373-1-phil@nwl.cc>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Mar 10, 2023 at 12:23:48PM +0100, Phil Sutter wrote:
> The kernel doesn't accept nat type chains with a priority of -200 or
> below. Catch this and provide a better error message than the kernel's
> EOPNOTSUPP.

LGTM
