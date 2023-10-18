Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA6F7CDB9A
	for <lists+netfilter-devel@lfdr.de>; Wed, 18 Oct 2023 14:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjJRM2i (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 18 Oct 2023 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229499AbjJRM2i (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:28:38 -0400
Received: from smtp-bc0f.mail.infomaniak.ch (smtp-bc0f.mail.infomaniak.ch [IPv6:2001:1600:3:17::bc0f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BF5010F
        for <netfilter-devel@vger.kernel.org>; Wed, 18 Oct 2023 05:28:34 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4S9VWN6SB9zMpnyK;
        Wed, 18 Oct 2023 12:28:32 +0000 (UTC)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4S9VWN3LfdzMppDh;
        Wed, 18 Oct 2023 14:28:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1697632112;
        bh=XLbZRMw4Qoxopp6BBhbSCSC9GK1oZ5vo3gS8znzlotU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=py0lZkyh9vcmSTPk0an7v1ye2el4ANTPJSB5h/r2L0Pf9+SY4IBzcXif+YM43nS69
         2CGZUe9Q2dAFtWHQ9MXHdmM3idT0hjOl5xNUFhRfYceJaagurCV4dVoAZdKRyqdv/a
         mkhOsNAlRgOKdHOrjvkWdy7MlQ0ytypcFIXrD7Uw=
Date:   Wed, 18 Oct 2023 14:28:30 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Cc:     willemdebruijn.kernel@gmail.com, gnoack3000@gmail.com,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        netfilter-devel@vger.kernel.org, yusongping@huawei.com,
        artem.kuzin@huawei.com
Subject: Re: [PATCH v13 01/12] landlock: Make ruleset's access masks more
 generic
Message-ID: <20231017.UXu7UP2ahree@digikod.net>
References: <20231016015030.1684504-1-konstantin.meskhidze@huawei.com>
 <20231016015030.1684504-2-konstantin.meskhidze@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016015030.1684504-2-konstantin.meskhidze@huawei.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

On Mon, Oct 16, 2023 at 09:50:19AM +0800, Konstantin Meskhidze wrote:
> To support network type rules, this modification renames ruleset's
> access masks and modifies it's type to access_masks_t. This patch
> adds filesystem helper functions to add and get filesystem mask.
> 
> Signed-off-by: Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
> Link: https://lore.kernel.org/r/20230920092641.832134-2-konstantin.meskhidze@huawei.com

Please don't include Link that points to the previous patch series. I
add them when I apply a patch series to identify its source.
