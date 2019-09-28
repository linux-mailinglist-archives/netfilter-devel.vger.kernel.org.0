Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AF34C0FEB
	for <lists+netfilter-devel@lfdr.de>; Sat, 28 Sep 2019 08:06:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725832AbfI1GG2 (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Sat, 28 Sep 2019 02:06:28 -0400
Received: from mail-40130.protonmail.ch ([185.70.40.130]:10283 "EHLO
        mail-40130.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbfI1GG1 (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Sat, 28 Sep 2019 02:06:27 -0400
Date:   Sat, 28 Sep 2019 06:06:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
        s=default; t=1569650785;
        bh=eWRrAOCCP9bI7GZS2mFwwl83JoAea4Tumovm1915ASo=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=X+kyPQYf2zkIU8TkHikBkD+pdoJTTJz6CgFl93+DbxEYLiVnMXLYRyC9iu2HOhWw9
         WYHJS6h9VN2gdN+4q2momHH6xbGd/mGlWTpXyj+IdvXYa18S0fR6fODCCHIvaUUwq6
         d1dRXAURXEN3dlXeVQrM0W9mZhkT54XhHtZA8Xow=
To:     "netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>
From:   Ttttabcd <ttttabcd@protonmail.com>
Reply-To: Ttttabcd <ttttabcd@protonmail.com>
Subject: Please add Bridge NAT in nftables
Message-ID: <NLT8x0veXvaS6Jvm2H2CHRbzeh2NPv1MBDGtt0t6C47TmsNN6vIjIw42_v6fGXIw552q8AUllbB4Lb09HXVihl_s5cgY9rZVC6qTMIQWaSc=@protonmail.com>
Feedback-ID: EvWK9os_-weOBrycfL_HEFp-ixys9sxnciOqqctCHB9kjCM4ip8VR9shOcMQZgeZ7RCnmNC4HYjcUKNMz31NBA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_REPLYTO
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

The NAT function is included in ebtables (although it is very simple, but i=
t is better than nothing), but I did not find the corresponding function in=
 nftables.

In ebtables there is only static NAT, no Masquerading, we can implement it =
in nftables

Implementing dynamic MAC NAT is very simple. We can use the IP address as a=
n identifier to convert the corresponding MAC. It is also simple to maintai=
n the conversion table. It is similar to the FIB of the switch, automatical=
ly learns, and the entries are discarded when timeout.

In MAC NAT is : IP -> MAC.

In the FIB of the switch is : MAC -> Dev Port.

In IPv4 NAT is : TCP Port -> IP.

This is easy to understand.


src: 192.168.1.50                                   src: 192.168.1.50
dst: 192.168.1.100                                 dst: 192.168.1.100
-----------------           ->    Bridge    ->   -----------------
src MAC: Host A                                   src MAC: Bridge
dst MAC: Host B                                   dst MAC: Host B

Now NAT learned that the MAC corresponding to 192.168.1.50 is Host A.

src: 192.168.1.100                                   src: 192.168.1.100
dst: 192.168.1.50                                 dst: 192.168.1.50
-----------------           <-    Bridge    <-    -----------------
src MAC: Host B                                    src MAC: Host B
dst MAC: Host A                                    dst MAC: Bridge

Host A does not know the existence of NAT at all.

Maybe you want to ask me now, why do you want to do this, the bridge can co=
mpletely forward the data frame directly?

But the reality is that it makes people feel a headache. In some cases, a d=
evice port can only correspond to one source MAC address. If a normal switc=
h requires multiple source MAC addresses, the network cannot be used!

Like those with security-restricted switches, or like wireless networks (wh=
en WDS is not supported), only a single source MAC can be used.

Dynamic MAC NAT is very important in these situations!
