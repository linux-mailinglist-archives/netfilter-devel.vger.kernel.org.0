Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F16FA4D73F2
	for <lists+netfilter-devel@lfdr.de>; Sun, 13 Mar 2022 10:23:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234111AbiCMJZC (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sun, 13 Mar 2022 05:25:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231891AbiCMJZC (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sun, 13 Mar 2022 05:25:02 -0400
X-Greylist: delayed 461 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 13 Mar 2022 01:23:55 PST
Received: from nodachi.mjopr.nl (nodachi.mjopr.nl [IPv6:2a03:ec80:0:100:215::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65971FA22D
        for <netfilter-devel@vger.kernel.org>; Sun, 13 Mar 2022 01:23:55 -0800 (PST)
Received: from [192.168.2.164] (unknown [143.176.158.61])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sander)
        by nodachi.mjopr.nl (Postfix) with ESMTPSA id 678F720062
        for <netfilter-devel@vger.kernel.org>; Sun, 13 Mar 2022 10:16:12 +0100 (CET)
Message-ID: <146db94f-3af8-a4ff-b386-cdc22bbb62da@users.sourceforge.net>
Date:   Sun, 13 Mar 2022 10:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Content-Language: en-US
From:   Pander <pander@users.sourceforge.net>
To:     netfilter-devel@vger.kernel.org
Subject: Xtables-addons geoip manual
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi all, ej,

I wrote a manual for installing and configuring Xtables-addons geoip

https://github.com/PanderMusubi/geoipblock/

Please review it and let me know about any improvements.

Thanks,

Pander

