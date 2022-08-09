Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C84458E1F0
	for <lists+netfilter-devel@lfdr.de>; Tue,  9 Aug 2022 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiHIVlT (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Tue, 9 Aug 2022 17:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiHIVkw (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Tue, 9 Aug 2022 17:40:52 -0400
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 07D81550A0
        for <netfilter-devel@vger.kernel.org>; Tue,  9 Aug 2022 14:40:51 -0700 (PDT)
Date:   Tue, 9 Aug 2022 23:40:47 +0200
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     netfilter-devel@vger.kernel.org
Subject: Re: [PATCH nf,v2 1/2] netfilter: nf_tables: upfront validation of
 data via nft_data_init()
Message-ID: <YvLUX+NHu4WN41JN@salvia>
References: <20220808173007.157055-1-pablo@netfilter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808173007.157055-1-pablo@netfilter.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Aug 08, 2022 at 07:30:06PM +0200, Pablo Neira Ayuso wrote:
> Instead of parsing the data and then validate that type and length are
> correct, pass a description of the expected data so it can be validated
> upfront before parsing it to bail out earlier.
> 
> This patch adds a new .size field to specify the maximum size of the
> data area. The .len field is optional and it is used as an input/output
> field, it provides the specific length of the expected data in the input
> path. If then .len field is not specified, then obtained length from the
> netlink attribute is stored. This is required by cmp, bitwise, range and
> immediate, which provide no netlink attribute that describes the data
> length. The immediate expression uses the destination register type to
> infer the expected data type.
> 
> Relying on opencoded validation of the expected data might lead to
> subtle bugs as described in 7e6bc1f6cabc ("netfilter: nf_tables:
> stricter validation of element data").

For the record, this series are applied
