Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 535951FC862
	for <lists+netfilter-devel@lfdr.de>; Wed, 17 Jun 2020 10:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726280AbgFQIRx (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Wed, 17 Jun 2020 04:17:53 -0400
Received: from mail.thelounge.net ([91.118.73.15]:56687 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725860AbgFQIRx (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:17:53 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49mycH0vzTzXSh;
        Wed, 17 Jun 2020 10:17:51 +0200 (CEST)
From:   Reindl Harald <h.reindl@thelounge.net>
Subject: ipset restore for bitmap:port terrible slow
Organization: the lounge interactive design
To:     netfilter-devel@vger.kernel.org
Message-ID: <ffe689dd-63d8-1b8f-42f2-20c875d124b6@thelounge.net>
Date:   Wed, 17 Jun 2020 10:17:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: netfilter-devel-owner@vger.kernel.org
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

Hi

the restore of a "bitmap:port" ipset with a lot of entries is *terrible*
slow, when you add a port-range like 42000–42999 it ends in 999 "add
PORTS_RESTRICTED" lines in the save-file and restore takes virtually ages

the cpu-time below is the whole systemd-unit which restores iptables,
ipset and configures the network with 3 nics, a bridge and wireguard

why is this *that much* inefficient given that the original command with
port ranges returns instantly?

on a datacenter firewall that makes the difference of 5 seconds or 15
seconds downtime at reboot

---------------------------

Name: PORTS_RESTRICTED
Type: bitmap:port
Header: range 1-55000

---------------------------

/usr/sbin/ipset -file /etc/sysconfig/ipset restore

CPU: 9.594s - Number of entries: 5192
CPU: 6.246s - Number of entries: 3192
CPU: 1.511s - Number of entries: 53

---------------------------

42000–42999 looks in /etc/sysconfig/ipset like below and frankly either
that can be speeded up or should be saved as ranges wherever it's
possible like hash:net prefers cidr

add PORTS_RESTRICTED 42000
add PORTS_RESTRICTED 42001
add PORTS_RESTRICTED 42002
add PORTS_RESTRICTED 42003
add PORTS_RESTRICTED 42004
add PORTS_RESTRICTED 42005
add PORTS_RESTRICTED 42006
add PORTS_RESTRICTED 42007
add PORTS_RESTRICTED 42008
add PORTS_RESTRICTED 42009
add PORTS_RESTRICTED 42010
add PORTS_RESTRICTED 42011
add PORTS_RESTRICTED 42012
add PORTS_RESTRICTED 42013
add PORTS_RESTRICTED 42014
add PORTS_RESTRICTED 42015
add PORTS_RESTRICTED 42016
add PORTS_RESTRICTED 42017
add PORTS_RESTRICTED 42018
add PORTS_RESTRICTED 42019
add PORTS_RESTRICTED 42020
add PORTS_RESTRICTED 42021
add PORTS_RESTRICTED 42022

---------------------------
