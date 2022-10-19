Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 355AC6039FB
	for <lists+netfilter-devel@lfdr.de>; Wed, 19 Oct 2022 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbiJSGor (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 19 Oct 2022 02:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiJSGoq (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 19 Oct 2022 02:44:46 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F40C826573
        for <netfilter-devel@vger.kernel.org>; Tue, 18 Oct 2022 23:44:44 -0700 (PDT)
Date:   Wed, 19 Oct 2022 08:44:41 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Ian Pilcher <arequipeno@gmail.com>
Cc:     netfilter-devel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] libnftnl: Fix res_id byte order
Message-ID: <Y0+c2Y3VtyXXFijD@salvia>
References: <20221018164528.250049-1-arequipeno@gmail.com>
 <20221018164528.250049-2-arequipeno@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221018164528.250049-2-arequipeno@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Oct 18, 2022 at 11:45:28AM -0500, Ian Pilcher wrote:
> The res_id member of struct nfgenmsg is supposed to be in network
> byte order (big endian).  Call htons() in __nftnl_nlmsg_build_hdr()
> to ensure that this is true on little endian systems.

LGTM, this is zero all the time at this moment. But it might be useful
in the future to bump it.
