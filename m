Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C333E6477E7
	for <lists+netfilter-devel@lfdr.de>; Thu,  8 Dec 2022 22:27:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbiLHV1O (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Thu, 8 Dec 2022 16:27:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiLHV1M (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Thu, 8 Dec 2022 16:27:12 -0500
Received: from mail.netfilter.org (mail.netfilter.org [217.70.188.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF47D786AD
        for <netfilter-devel@vger.kernel.org>; Thu,  8 Dec 2022 13:27:11 -0800 (PST)
Date:   Thu, 8 Dec 2022 22:27:08 +0100
From:   Pablo Neira Ayuso <pablo@netfilter.org>
To:     Jeremy Sowden <jeremy@azazel.net>
Cc:     Netfilter Devel <netfilter-devel@vger.kernel.org>
Subject: Re: [PATCH ulogd2] pgsql: correct `ulog2.ip_totlen` type
Message-ID: <Y5JWrNpThFqFTOon@salvia>
References: <20221129211127.246934-1-jeremy@azazel.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221129211127.246934-1-jeremy@azazel.net>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Tue, Nov 29, 2022 at 09:11:27PM +0000, Jeremy Sowden wrote:
> The types of `ip_totlen` in the `ulog` view and the `INSERT_IP_PACKET_FULL`
> function are `integer`, but the column in the `ulog2` table is `smallint`.  The
> "total length" field of an IP packet is an unsigned 16-bit integer, whereas
> `smallint` in PostgreSQL is a signed 16-bit integer type.  Change the type of
> `ulog2.ip_totlen` to `integer`.

Also applied this to ulogd2, thanks.
