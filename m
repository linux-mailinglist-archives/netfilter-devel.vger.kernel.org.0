Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E3F26671BA
	for <lists+netfilter-devel@lfdr.de>; Thu, 12 Jan 2023 13:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjALMLj (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 12 Jan 2023 07:11:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbjALMLL (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 12 Jan 2023 07:11:11 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7C27AE63;
        Thu, 12 Jan 2023 04:06:19 -0800 (PST)
Date:   Thu, 12 Jan 2023 13:06:13 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Martin Zaharinov <micron10@gmail.com>
Cc:     20230106010251.27038-1-pablo@netfilter.org,
        netfilter <netfilter@vger.kernel.org>,
        netfilter-devel@vger.kernel.org
Subject: Re: [nft] src: allow for updating devices on existing netdev chain -
 Test result
Message-ID: <Y7/3tau2t+5fe2GK@salvia>
References: <DD658C3B-2FB9-451E-893C-EE37ABDC678A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DD658C3B-2FB9-451E-893C-EE37ABDC678A@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Fri, Jan 06, 2023 at 05:17:51PM +0200, Martin Zaharinov wrote:
> Hi Pablo
> 
> Patch look good and work but in my test after try to add ppp0 on
> over chain 1024 receive : Error: Could not process rule: Argument
> list too long

You are hitting the maximum number of hooks per device (1024). I think you
perhaps would like to do something like:

for i in `seq 2 9999`; do echo "add chain netdev qos int { devices = { ppp$i } ; }" >> /tmp/ruleset.nft; done

instead?
