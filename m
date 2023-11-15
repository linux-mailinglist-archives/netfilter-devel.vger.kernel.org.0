Return-Path: <netfilter-devel-owner@vger.kernel.org>
X-Original-To: lists+netfilter-devel@lfdr.de
Delivered-To: lists+netfilter-devel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 696EE7E0825
	for <lists+netfilter-devel@lfdr.de>; Fri,  3 Nov 2023 19:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343516AbjKCSaQ (ORCPT <rfc822;lists+netfilter-devel@lfdr.de>);
        Fri, 3 Nov 2023 14:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233934AbjKCSaN (ORCPT
        <rfc822;netfilter-devel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:30:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34012D4B
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699036167;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=PsgVWWt62cfPCj15I8QlZRZ1u64cvm9jCmn3gi12+7E=;
        b=JjsLaMJd1Xb8TvGai9++UHF48hnUqDLxuRSI4xITfA7M4Nqs/4almweoIucdxxdK7gwfUa
        Ba72oekX8tpucbmYmT5s9MjUqzRISd2isokupFmIUx9O3qOdpWWKThRlws8JADpIF5vKF1
        vt0R7c9MoJmxOME8S5SjR1o3rQNIQYI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-p34Rc9RmOequIDilZYn_3g-1; Fri, 03 Nov 2023 14:29:13 -0400
X-MC-Unique: p34Rc9RmOequIDilZYn_3g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F00438A2F41
        for <netfilter-devel@vger.kernel.org>; Fri,  3 Nov 2023 18:29:12 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.39.193.47])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1444D2166B27;
        Fri,  3 Nov 2023 18:29:11 +0000 (UTC)
From:   Thomas Haller <thaller@redhat.com>
To:     NetFilter <netfilter-devel@vger.kernel.org>
Cc:     Thomas Haller <thaller@redhat.com>
Subject: [PATCH nft v2 0/6] add and check dump files for JSON in tests/shell
Date:   Fri,  3 Nov 2023 19:25:57 +0100
Message-ID: <20231103182901.3795263-1-thaller@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <netfilter-devel.vger.kernel.org>
X-Mailing-List: netfilter-devel@vger.kernel.org

v2:

- no longer workaround bug in stmt_print_json(), which due to
  "chain_stmt_ops.json" being NULL prints something to stderr.
  Instead, workaround the test in "tests/shell/helpers/test-wrapper.sh"

- reword commit messages, and minor code cleanups.

- drop more .json-nft files that cause the tests to fail.
  You can find missing .json-nft files by running "./tools/check-tree.sh".
  This needs to be fixed with time.

Thomas Haller (6):
  json: fix use after free in table_flags_json()
  tests/shell: check and generate JSON dump files
  tests/shell: add JSON dump files
  tools: simplify error handling in "check-tree.sh" by adding
    msg_err()/msg_warn()
  tools: check more strictly for bash shebang in "check-tree.sh"
  tools: check for consistency of .json-nft dumps in "check-tree.sh"

 src/json.c                                    |   2 +-
 tests/shell/helpers/test-wrapper.sh           | 143 +++++++++++++-----
 tests/shell/run-tests.sh                      |  11 +-
 .../bitwise/dumps/0040mark_binop_0.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_1.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_2.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_3.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_4.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_5.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_6.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_7.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_8.json-nft   |   1 +
 .../bitwise/dumps/0040mark_binop_9.json-nft   |   1 +
 .../bogons/dumps/assert_failures.json-nft     |   1 +
 .../dumps/0001_cache_handling_0.json-nft      |   1 +
 .../cache/dumps/0002_interval_0.json-nft      |   1 +
 .../cache/dumps/0003_cache_update_0.json-nft  |   1 +
 .../cache/dumps/0004_cache_update_0.json-nft  |   1 +
 .../dumps/0005_cache_chain_flush.json-nft     |   1 +
 .../dumps/0006_cache_table_flush.json-nft     |   1 +
 .../dumps/0007_echo_cache_init_0.json-nft     |   1 +
 .../dumps/0008_delete_by_handle_0.json-nft    |   1 +
 ...0009_delete_by_handle_incorrect_0.json-nft |   1 +
 .../cache/dumps/0011_index_0.json-nft         |   1 +
 .../chains/dumps/0001jumps_0.json-nft         |   1 +
 .../chains/dumps/0002jumps_1.json-nft         |   1 +
 .../chains/dumps/0003jump_loop_1.json-nft     |   1 +
 .../chains/dumps/0004busy_1.json-nft          |   1 +
 .../chains/dumps/0005busy_map_1.json-nft      |   1 +
 .../chains/dumps/0006masquerade_0.json-nft    |   1 +
 .../chains/dumps/0007masquerade_1.json-nft    |   1 +
 .../dumps/0008masquerade_jump_1.json-nft      |   1 +
 .../dumps/0009masquerade_jump_1.json-nft      |   1 +
 .../dumps/0010endless_jump_loop_1.json-nft    |   1 +
 .../chains/dumps/0013rename_0.json-nft        |   1 +
 .../chains/dumps/0014rename_0.json-nft        |   1 +
 .../dumps/0015check_jump_loop_1.json-nft      |   1 +
 .../chains/dumps/0016delete_handle_0.json-nft |   1 +
 .../dumps/0017masquerade_jump_1.json-nft      |   1 +
 .../dumps/0018check_jump_loop_1.json-nft      |   1 +
 .../dumps/0019masquerade_jump_1.json-nft      |   1 +
 .../chains/dumps/0020depth_1.json-nft         |   1 +
 .../chains/dumps/0021prio_0.json-nft          |   1 +
 .../chains/dumps/0022prio_dummy_1.json-nft    |   1 +
 .../dumps/0023prio_inet_srcnat_1.json-nft     |   1 +
 .../dumps/0024prio_inet_dstnat_1.json-nft     |   1 +
 .../chains/dumps/0025prio_arp_1.json-nft      |   1 +
 .../chains/dumps/0026prio_netdev_1.json-nft   |   1 +
 .../dumps/0027prio_bridge_dstnat_1.json-nft   |   1 +
 .../dumps/0028prio_bridge_out_1.json-nft      |   1 +
 .../dumps/0029prio_bridge_srcnat_1.json-nft   |   1 +
 .../chains/dumps/0030create_0.json-nft        |   1 +
 .../dumps/0031priority_variable_0.json-nft    |   1 +
 .../dumps/0032priority_variable_0.json-nft    |   1 +
 .../dumps/0033priority_variable_1.json-nft    |   1 +
 .../dumps/0034priority_variable_1.json-nft    |   1 +
 .../dumps/0035policy_variable_0.json-nft      |   1 +
 .../dumps/0036policy_variable_0.json-nft      |   1 +
 .../dumps/0037policy_variable_1.json-nft      |   1 +
 .../dumps/0038policy_variable_1.json-nft      |   1 +
 .../dumps/0039negative_priority_0.json-nft    |   1 +
 .../dumps/0042chain_variable_0.json-nft       |   1 +
 .../chains/dumps/0043chain_ingress_0.json-nft |   1 +
 .../chains/dumps/0044chain_destroy_0.json-nft |   1 +
 .../chains/dumps/netdev_chain_0.json-nft      |   1 +
 .../dumps/netdev_chain_autoremove.json-nft    |   1 +
 .../comments/dumps/comments_0.json-nft        |   1 +
 .../flowtable/dumps/0001flowtable_0.json-nft  |   1 +
 .../dumps/0002create_flowtable_0.json-nft     |   1 +
 .../dumps/0003add_after_flush_0.json-nft      |   1 +
 .../dumps/0004delete_after_add_0.json-nft     |   1 +
 .../dumps/0005delete_in_use_1.json-nft        |   1 +
 .../flowtable/dumps/0006segfault_0.json-nft   |   1 +
 .../flowtable/dumps/0007prio_0.json-nft       |   1 +
 .../flowtable/dumps/0008prio_1.json-nft       |   1 +
 .../dumps/0009deleteafterflush_0.json-nft     |   1 +
 .../dumps/0010delete_handle_0.json-nft        |   1 +
 .../dumps/0011deleteafterflush_0.json-nft     |   1 +
 .../dumps/0012flowtable_variable_0.json-nft   |   1 +
 .../dumps/0013addafterdelete_0.json-nft       |   1 +
 .../dumps/0014addafterdelete_0.json-nft       |   1 +
 .../flowtable/dumps/0015destroy_0.json-nft    |   1 +
 .../include/dumps/0001absolute_0.json-nft     |   1 +
 .../include/dumps/0002relative_0.json-nft     |   1 +
 .../include/dumps/0003includepath_0.json-nft  |   1 +
 .../include/dumps/0004endlessloop_1.json-nft  |   1 +
 .../include/dumps/0005glob_empty_0.json-nft   |   1 +
 .../include/dumps/0006glob_single_0.json-nft  |   1 +
 .../include/dumps/0007glob_double_0.json-nft  |   1 +
 .../dumps/0008glob_nofile_wildcard_0.json-nft |   1 +
 .../include/dumps/0009glob_nofile_1.json-nft  |   1 +
 .../dumps/0010glob_broken_file_1.json-nft     |   1 +
 .../dumps/0011glob_dependency_0.json-nft      |   1 +
 .../dumps/0012glob_dependency_1.json-nft      |   1 +
 .../include/dumps/0013glob_dotfile_0.json-nft |   1 +
 ...nput_descriptors_included_files_0.json-nft |   1 +
 .../dumps/0014glob_directory_0.json-nft       |   1 +
 .../dumps/0015doubleincludepath_0.json-nft    |   1 +
 .../include/dumps/0016maxdepth_0.json-nft     |   1 +
 .../0017glob_more_than_maxdepth_1.json-nft    |   1 +
 .../dumps/0018include_error_0.json-nft        |   1 +
 .../dumps/0019include_error_0.json-nft        |   1 +
 .../dumps/0020include_chain_0.json-nft        |   1 +
 .../json/dumps/0001set_statements_0.json-nft  |   1 +
 .../json/dumps/0002table_map_0.json-nft       |   1 +
 .../dumps/0003json_schema_version_0.json-nft  |   1 +
 .../dumps/0004json_schema_version_1.json-nft  |   1 +
 .../json/dumps/0005secmark_objref_0.json-nft  |   1 +
 .../json/dumps/0006obj_comment_0.json-nft     |   1 +
 .../testcases/json/dumps/netdev.json-nft      |   1 +
 .../listing/dumps/0001ruleset_0.json-nft      |   1 +
 .../listing/dumps/0002ruleset_0.json-nft      |   1 +
 .../listing/dumps/0003table_0.json-nft        |   1 +
 .../listing/dumps/0004table_0.json-nft        |   1 +
 .../listing/dumps/0005ruleset_ip_0.json-nft   |   1 +
 .../listing/dumps/0006ruleset_ip6_0.json-nft  |   1 +
 .../listing/dumps/0007ruleset_inet_0.json-nft |   1 +
 .../listing/dumps/0008ruleset_arp_0.json-nft  |   1 +
 .../dumps/0009ruleset_bridge_0.json-nft       |   1 +
 .../listing/dumps/0010sets_0.json-nft         |   1 +
 .../listing/dumps/0011sets_0.json-nft         |   1 +
 .../listing/dumps/0012sets_0.json-nft         |   1 +
 .../listing/dumps/0014objects_0.json-nft      |   1 +
 .../listing/dumps/0015dynamic_0.json-nft      |   1 +
 .../listing/dumps/0016anonymous_0.json-nft    |   1 +
 .../listing/dumps/0017objects_0.json-nft      |   1 +
 .../listing/dumps/0018data_0.json-nft         |   1 +
 .../listing/dumps/0019set_0.json-nft          |   1 +
 .../listing/dumps/0020flowtable_0.json-nft    |   1 +
 .../dumps/0021ruleset_json_terse_0.json-nft   |   1 +
 .../listing/dumps/0022terse_0.json-nft        |   1 +
 .../0003map_add_many_elements_0.json-nft      |   1 +
 ...5interval_map_add_many_elements_0.json-nft |   1 +
 .../dumps/0006interval_map_overlap_0.json-nft |   1 +
 .../dumps/0007named_ifname_dtype_0.json-nft   |   1 +
 .../dumps/0008interval_map_delete_0.json-nft  |   1 +
 .../testcases/maps/dumps/0009vmap_0.json-nft  |   1 +
 .../testcases/maps/dumps/0012map_0.json-nft   |   1 +
 .../testcases/maps/dumps/0013map_0.json-nft   |   1 +
 .../maps/dumps/0014destroy_0.json-nft         |   1 +
 .../maps/dumps/0016map_leak_0.json-nft        |   1 +
 .../maps/dumps/0017_map_variable_0.json-nft   |   1 +
 .../dumps/0018map_leak_timeout_0.json-nft     |   1 +
 .../maps/dumps/anon_objmap_concat.json-nft    |   1 +
 .../maps/dumps/anonymous_snat_map_0.json-nft  |   1 +
 .../maps/dumps/different_map_types_1.json-nft |   1 +
 .../map_catchall_double_deactivate.json-nft   |   1 +
 .../maps/dumps/map_with_flags_0.json-nft      |   1 +
 .../maps/dumps/named_snat_map_0.json-nft      |   1 +
 .../dumps/typeof_maps_add_delete.json-nft     |   1 +
 .../maps/dumps/typeof_maps_update_0.json-nft  |   1 +
 .../netns/dumps/0001nft-f_0.json-nft          |   1 +
 .../netns/dumps/0002loosecommands_0.json-nft  |   1 +
 .../testcases/netns/dumps/0003many_0.json-nft |   1 +
 .../nft-f/dumps/0001define_slash_0.json-nft   |   1 +
 .../nft-f/dumps/0002rollback_rule_0.json-nft  |   1 +
 .../nft-f/dumps/0003rollback_jump_0.json-nft  |   1 +
 .../nft-f/dumps/0004rollback_set_0.json-nft   |   1 +
 .../nft-f/dumps/0005rollback_map_0.json-nft   |   1 +
 .../nft-f/dumps/0006action_object_0.json-nft  |   1 +
 .../0007action_object_set_segfault_1.json-nft |   1 +
 .../nft-f/dumps/0008split_tables_0.json-nft   |   1 +
 .../nft-f/dumps/0009variable_0.json-nft       |   1 +
 .../nft-f/dumps/0010variable_0.json-nft       |   1 +
 .../nft-f/dumps/0013defines_1.json-nft        |   1 +
 .../nft-f/dumps/0014defines_1.json-nft        |   1 +
 .../nft-f/dumps/0015defines_1.json-nft        |   1 +
 .../nft-f/dumps/0016redefines_1.json-nft      |   1 +
 .../dumps/0018ct_expectation_obj_0.json-nft   |   1 +
 .../nft-f/dumps/0018jump_variable_0.json-nft  |   1 +
 .../nft-f/dumps/0019jump_variable_1.json-nft  |   1 +
 .../nft-f/dumps/0020jump_variable_1.json-nft  |   1 +
 .../nft-f/dumps/0021list_ruleset_0.json-nft   |   1 +
 .../nft-f/dumps/0022variables_0.json-nft      |   1 +
 .../nft-f/dumps/0023check_1.json-nft          |   1 +
 .../nft-f/dumps/0025empty_dynset_0.json-nft   |   1 +
 .../nft-f/dumps/0026listing_0.json-nft        |   1 +
 .../nft-f/dumps/0027split_chains_0.json-nft   |   1 +
 .../dumps/0028variable_cmdline_0.json-nft     |   1 +
 .../nft-f/dumps/0029split_file_0.json-nft     |   1 +
 .../nft-f/dumps/0030variable_reuse_0.json-nft |   1 +
 .../nft-f/dumps/0031vmap_string_0.json-nft    |   1 +
 .../nft-f/dumps/0032pknock_0.json-nft         |   1 +
 .../nft-i/dumps/0001define_0.json-nft         |   1 +
 .../dumps/dependency_kill.json-nft            |   1 +
 .../optimizations/dumps/merge_nat.json-nft    |   1 +
 .../optimizations/dumps/merge_reject.json-nft |   1 +
 .../optimizations/dumps/merge_stmts.json-nft  |   1 +
 .../dumps/merge_stmts_concat.json-nft         |   1 +
 .../dumps/merge_stmts_concat_vmap.json-nft    |   1 +
 .../dumps/merge_stmts_vmap.json-nft           |   1 +
 .../dumps/merge_vmap_raw.json-nft             |   1 +
 .../optimizations/dumps/merge_vmaps.json-nft  |   1 +
 .../dumps/not_mergeable.json-nft              |   1 +
 .../optimizations/dumps/ruleset.json-nft      |   1 +
 .../dumps/single_anon_set.json-nft            |   1 +
 .../optimizations/dumps/skip_merge.json-nft   |   1 +
 .../optimizations/dumps/skip_non_eq.json-nft  |   1 +
 .../dumps/skip_unsupported.json-nft           |   1 +
 .../optimizations/dumps/variables.json-nft    |   1 +
 .../optionals/dumps/comments_0.json-nft       |   1 +
 .../optionals/dumps/comments_chain_0.json-nft |   1 +
 .../dumps/comments_handles_0.json-nft         |   1 +
 .../dumps/comments_objects_dup_0.json-nft     |   1 +
 .../optionals/dumps/comments_table_0.json-nft |   1 +
 .../dumps/delete_object_handles_0.json-nft    |   1 +
 .../optionals/dumps/handles_0.json-nft        |   1 +
 .../optionals/dumps/handles_1.json-nft        |   1 +
 .../optionals/dumps/log_prefix_0.json-nft     |   1 +
 .../dumps/update_object_handles_0.json-nft    |   1 +
 .../owner/dumps/0001-flowtable-uaf.json-nft   |   1 +
 .../testcases/parsing/dumps/describe.json-nft |   1 +
 .../testcases/parsing/dumps/log.json-nft      |   1 +
 .../testcases/parsing/dumps/octal.json-nft    |   1 +
 .../dumps/0001addinsertposition_0.json-nft    |   1 +
 .../dumps/0002addinsertlocation_1.json-nft    |   1 +
 .../dumps/0003insert_0.json-nft               |   1 +
 .../dumps/0004replace_0.json-nft              |   1 +
 .../dumps/0005replace_1.json-nft              |   1 +
 .../dumps/0006replace_1.json-nft              |   1 +
 .../dumps/0007delete_0.json-nft               |   1 +
 .../dumps/0008delete_1.json-nft               |   1 +
 .../dumps/0009delete_1.json-nft               |   1 +
 .../dumps/0010replace_0.json-nft              |   1 +
 .../dumps/0011reset_0.json-nft                |   1 +
 .../dumps/0012destroy_0.json-nft              |   1 +
 .../sets/dumps/0001named_interval_0.json-nft  |   1 +
 .../0002named_interval_automerging_0.json-nft |   1 +
 ...0003named_interval_missing_flag_0.json-nft |   1 +
 .../0004named_interval_shadow_0.json-nft      |   1 +
 .../0005named_interval_shadow_0.json-nft      |   1 +
 .../sets/dumps/0006create_set_0.json-nft      |   1 +
 .../sets/dumps/0007create_element_0.json-nft  |   1 +
 .../dumps/0008comments_interval_0.json-nft    |   1 +
 .../dumps/0009comments_timeout_0.json-nft     |   1 +
 .../sets/dumps/0010comments_0.json-nft        |   1 +
 .../0012add_delete_many_elements_0.json-nft   |   1 +
 .../0013add_delete_many_elements_0.json-nft   |   1 +
 ...014malformed_set_is_not_defined_0.json-nft |   1 +
 .../sets/dumps/0015rulesetflush_0.json-nft    |   1 +
 .../sets/dumps/0016element_leak_0.json-nft    |   1 +
 .../sets/dumps/0017add_after_flush_0.json-nft |   1 +
 .../sets/dumps/0018set_check_size_1.json-nft  |   1 +
 .../sets/dumps/0019set_check_size_0.json-nft  |   1 +
 .../sets/dumps/0020comments_0.json-nft        |   1 +
 .../sets/dumps/0021nesting_0.json-nft         |   1 +
 .../dumps/0022type_selective_flush_0.json-nft |   1 +
 .../0023incomplete_add_set_command_0.json-nft |   1 +
 .../sets/dumps/0025anonymous_set_0.json-nft   |   1 +
 .../sets/dumps/0026named_limit_0.json-nft     |   1 +
 .../sets/dumps/0027ipv6_maps_ipv4_0.json-nft  |   1 +
 .../sets/dumps/0028autoselect_0.json-nft      |   1 +
 .../sets/dumps/0028delete_handle_0.json-nft   |   1 +
 .../dumps/0032restore_set_simple_0.json-nft   |   1 +
 .../dumps/0033add_set_simple_flat_0.json-nft  |   1 +
 .../sets/dumps/0034get_element_0.json-nft     |   1 +
 .../0035add_set_elements_flat_0.json-nft      |   1 +
 .../0037_set_with_inet_service_0.json-nft     |   1 +
 .../sets/dumps/0038meter_list_0.json-nft      |   1 +
 .../sets/dumps/0039delete_interval_0.json-nft |   1 +
 .../0040get_host_endian_elements_0.json-nft   |   1 +
 .../sets/dumps/0041interval_0.json-nft        |   1 +
 .../sets/dumps/0042update_set_0.json-nft      |   1 +
 .../dumps/0043concatenated_ranges_0.json-nft  |   1 +
 .../dumps/0043concatenated_ranges_1.json-nft  |   1 +
 .../dumps/0044interval_overlap_1.json-nft     |   1 +
 .../dumps/0045concat_ipv4_service.json-nft    |   1 +
 .../sets/dumps/0046netmap_0.json-nft          |   1 +
 .../sets/dumps/0048set_counters_0.json-nft    |   1 +
 .../sets/dumps/0049set_define_0.json-nft      |   1 +
 .../sets/dumps/0050set_define_1.json-nft      |   1 +
 .../dumps/0051set_interval_counter_0.json-nft |   1 +
 .../sets/dumps/0052overlap_0.json-nft         |   1 +
 .../testcases/sets/dumps/0053echo_0.json-nft  |   1 +
 .../sets/dumps/0054comments_set_0.json-nft    |   1 +
 .../sets/dumps/0055tcpflags_0.json-nft        |   1 +
 .../sets/dumps/0056dynamic_limit_0.json-nft   |   1 +
 .../dumps/0057set_create_fails_0.json-nft     |   1 +
 .../dumps/0058_setupdate_timeout_0.json-nft   |   1 +
 .../dumps/0059set_update_multistmt_0.json-nft |   1 +
 .../sets/dumps/0060set_multistmt_0.json-nft   |   1 +
 .../sets/dumps/0060set_multistmt_1.json-nft   |   1 +
 .../dumps/0061anonymous_automerge_0.json-nft  |   1 +
 .../sets/dumps/0062set_connlimit_0.json-nft   |   1 +
 .../sets/dumps/0063set_catchall_0.json-nft    |   1 +
 .../sets/dumps/0064map_catchall_0.json-nft    |   1 +
 .../dumps/0065_icmp_postprocessing.json-nft   |   1 +
 .../sets/dumps/0069interval_merge_0.json-nft  |   1 +
 .../0071unclosed_prefix_interval_0.json-nft   |   1 +
 .../sets/dumps/0072destroy_0.json-nft         |   1 +
 .../sets/dumps/0073flat_interval_set.json-nft |   1 +
 .../dumps/0074nested_interval_set.json-nft    |   1 +
 .../sets/dumps/collapse_elem_0.json-nft       |   1 +
 .../sets/dumps/concat_interval_0.json-nft     |   1 +
 .../sets/dumps/dynset_missing.json-nft        |   1 +
 .../testcases/sets/dumps/errors_0.json-nft    |   1 +
 .../sets/dumps/exact_overlap_0.json-nft       |   1 +
 .../testcases/sets/dumps/inner_0.json-nft     |   1 +
 .../testcases/sets/dumps/set_eval_0.json-nft  |   1 +
 .../sets/dumps/type_set_symbol.json-nft       |   1 +
 .../transactions/dumps/0001table_0.json-nft   |   1 +
 .../transactions/dumps/0002table_0.json-nft   |   1 +
 .../transactions/dumps/0003table_0.json-nft   |   1 +
 .../transactions/dumps/0010chain_0.json-nft   |   1 +
 .../transactions/dumps/0011chain_0.json-nft   |   1 +
 .../transactions/dumps/0012chain_0.json-nft   |   1 +
 .../transactions/dumps/0013chain_0.json-nft   |   1 +
 .../transactions/dumps/0014chain_1.json-nft   |   1 +
 .../transactions/dumps/0015chain_0.json-nft   |   1 +
 .../transactions/dumps/0020rule_0.json-nft    |   1 +
 .../transactions/dumps/0021rule_0.json-nft    |   1 +
 .../transactions/dumps/0022rule_1.json-nft    |   1 +
 .../transactions/dumps/0023rule_1.json-nft    |   1 +
 .../transactions/dumps/0024rule_0.json-nft    |   1 +
 .../transactions/dumps/0025rule_0.json-nft    |   1 +
 .../transactions/dumps/0030set_0.json-nft     |   1 +
 .../transactions/dumps/0031set_0.json-nft     |   1 +
 .../transactions/dumps/0032set_0.json-nft     |   1 +
 .../transactions/dumps/0033set_0.json-nft     |   1 +
 .../transactions/dumps/0034set_0.json-nft     |   1 +
 .../transactions/dumps/0035set_0.json-nft     |   1 +
 .../transactions/dumps/0036set_1.json-nft     |   1 +
 .../transactions/dumps/0037set_0.json-nft     |   1 +
 .../transactions/dumps/0038set_0.json-nft     |   1 +
 .../transactions/dumps/0039set_0.json-nft     |   1 +
 .../transactions/dumps/0040set_0.json-nft     |   1 +
 .../dumps/0041nat_restore_0.json-nft          |   1 +
 .../dumps/0042_stateful_expr_0.json-nft       |   1 +
 .../transactions/dumps/0043set_1.json-nft     |   1 +
 .../transactions/dumps/0044rule_0.json-nft    |   1 +
 .../dumps/0045anon-unbind_0.json-nft          |   1 +
 .../transactions/dumps/0046set_0.json-nft     |   1 +
 .../transactions/dumps/0047set_0.json-nft     |   1 +
 .../transactions/dumps/0048helpers_0.json-nft |   1 +
 .../transactions/dumps/0049huge_0.json-nft    |   1 +
 .../transactions/dumps/0050rule_1.json-nft    |   1 +
 .../transactions/dumps/30s-stress.json-nft    |   1 +
 .../dumps/anon_chain_loop.json-nft            |   1 +
 .../dumps/bad_expression.json-nft             |   1 +
 .../transactions/dumps/table_onoff.json-nft   |   1 +
 tools/check-tree.sh                           |  63 +++++---
 341 files changed, 498 insertions(+), 58 deletions(-)
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_0.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_1.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_2.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_3.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_4.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_5.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_6.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_7.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_8.json-nft
 create mode 100644 tests/shell/testcases/bitwise/dumps/0040mark_binop_9.json-nft
 create mode 100644 tests/shell/testcases/bogons/dumps/assert_failures.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0001_cache_handling_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0002_interval_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0003_cache_update_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0004_cache_update_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0005_cache_chain_flush.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0006_cache_table_flush.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0007_echo_cache_init_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0008_delete_by_handle_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0009_delete_by_handle_incorrect_0.json-nft
 create mode 100644 tests/shell/testcases/cache/dumps/0011_index_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0001jumps_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0002jumps_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0003jump_loop_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0004busy_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0005busy_map_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0006masquerade_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0007masquerade_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0008masquerade_jump_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0009masquerade_jump_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0010endless_jump_loop_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0013rename_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0014rename_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0015check_jump_loop_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0016delete_handle_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0017masquerade_jump_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0018check_jump_loop_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0019masquerade_jump_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0020depth_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0021prio_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0022prio_dummy_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0023prio_inet_srcnat_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0024prio_inet_dstnat_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0025prio_arp_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0026prio_netdev_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0027prio_bridge_dstnat_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0028prio_bridge_out_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0029prio_bridge_srcnat_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0030create_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0031priority_variable_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0032priority_variable_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0033priority_variable_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0034priority_variable_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0035policy_variable_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0036policy_variable_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0037policy_variable_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0038policy_variable_1.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0039negative_priority_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0042chain_variable_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0043chain_ingress_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/0044chain_destroy_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/netdev_chain_0.json-nft
 create mode 100644 tests/shell/testcases/chains/dumps/netdev_chain_autoremove.json-nft
 create mode 100644 tests/shell/testcases/comments/dumps/comments_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0001flowtable_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0002create_flowtable_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0003add_after_flush_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0004delete_after_add_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0005delete_in_use_1.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0006segfault_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0007prio_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0008prio_1.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0009deleteafterflush_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0010delete_handle_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0011deleteafterflush_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0012flowtable_variable_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0013addafterdelete_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0014addafterdelete_0.json-nft
 create mode 100644 tests/shell/testcases/flowtable/dumps/0015destroy_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0001absolute_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0002relative_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0003includepath_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0004endlessloop_1.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0005glob_empty_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0006glob_single_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0007glob_double_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0008glob_nofile_wildcard_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0009glob_nofile_1.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0010glob_broken_file_1.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0011glob_dependency_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0012glob_dependency_1.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0013glob_dotfile_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0013input_descriptors_included_files_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0014glob_directory_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0015doubleincludepath_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0016maxdepth_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0017glob_more_than_maxdepth_1.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0018include_error_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0019include_error_0.json-nft
 create mode 100644 tests/shell/testcases/include/dumps/0020include_chain_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0001set_statements_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0002table_map_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0003json_schema_version_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0004json_schema_version_1.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0005secmark_objref_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/0006obj_comment_0.json-nft
 create mode 100644 tests/shell/testcases/json/dumps/netdev.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0001ruleset_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0002ruleset_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0003table_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0004table_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0005ruleset_ip_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0006ruleset_ip6_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0007ruleset_inet_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0008ruleset_arp_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0009ruleset_bridge_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0010sets_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0011sets_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0012sets_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0014objects_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0015dynamic_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0016anonymous_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0017objects_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0018data_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0019set_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0020flowtable_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0021ruleset_json_terse_0.json-nft
 create mode 100644 tests/shell/testcases/listing/dumps/0022terse_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0003map_add_many_elements_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0005interval_map_add_many_elements_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0006interval_map_overlap_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0007named_ifname_dtype_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0008interval_map_delete_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0009vmap_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0012map_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0013map_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0014destroy_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0016map_leak_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0017_map_variable_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/0018map_leak_timeout_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/anon_objmap_concat.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/anonymous_snat_map_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/different_map_types_1.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/map_catchall_double_deactivate.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/map_with_flags_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/named_snat_map_0.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/typeof_maps_add_delete.json-nft
 create mode 100644 tests/shell/testcases/maps/dumps/typeof_maps_update_0.json-nft
 create mode 100644 tests/shell/testcases/netns/dumps/0001nft-f_0.json-nft
 create mode 100644 tests/shell/testcases/netns/dumps/0002loosecommands_0.json-nft
 create mode 100644 tests/shell/testcases/netns/dumps/0003many_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0001define_slash_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0002rollback_rule_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0003rollback_jump_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0004rollback_set_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0005rollback_map_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0006action_object_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0007action_object_set_segfault_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0008split_tables_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0009variable_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0010variable_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0013defines_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0014defines_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0015defines_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0016redefines_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0018ct_expectation_obj_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0018jump_variable_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0019jump_variable_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0020jump_variable_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0021list_ruleset_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0022variables_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0023check_1.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0025empty_dynset_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0026listing_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0027split_chains_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0028variable_cmdline_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0029split_file_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0030variable_reuse_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0031vmap_string_0.json-nft
 create mode 100644 tests/shell/testcases/nft-f/dumps/0032pknock_0.json-nft
 create mode 100644 tests/shell/testcases/nft-i/dumps/0001define_0.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/dependency_kill.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_nat.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_reject.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_stmts.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_stmts_concat.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_stmts_concat_vmap.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_stmts_vmap.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_vmap_raw.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/merge_vmaps.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/not_mergeable.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/ruleset.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/single_anon_set.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/skip_merge.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/skip_non_eq.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/skip_unsupported.json-nft
 create mode 100644 tests/shell/testcases/optimizations/dumps/variables.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/comments_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/comments_chain_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/comments_handles_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/comments_objects_dup_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/comments_table_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/delete_object_handles_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/handles_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/handles_1.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/log_prefix_0.json-nft
 create mode 100644 tests/shell/testcases/optionals/dumps/update_object_handles_0.json-nft
 create mode 100644 tests/shell/testcases/owner/dumps/0001-flowtable-uaf.json-nft
 create mode 100644 tests/shell/testcases/parsing/dumps/describe.json-nft
 create mode 100644 tests/shell/testcases/parsing/dumps/log.json-nft
 create mode 100644 tests/shell/testcases/parsing/dumps/octal.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0001addinsertposition_0.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0002addinsertlocation_1.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0003insert_0.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0004replace_0.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0005replace_1.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0006replace_1.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0007delete_0.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0008delete_1.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0009delete_1.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0010replace_0.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0011reset_0.json-nft
 create mode 100644 tests/shell/testcases/rule_management/dumps/0012destroy_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0001named_interval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0002named_interval_automerging_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0003named_interval_missing_flag_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0004named_interval_shadow_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0005named_interval_shadow_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0006create_set_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0007create_element_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0008comments_interval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0009comments_timeout_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0010comments_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0012add_delete_many_elements_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0013add_delete_many_elements_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0014malformed_set_is_not_defined_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0015rulesetflush_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0016element_leak_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0017add_after_flush_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0018set_check_size_1.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0019set_check_size_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0020comments_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0021nesting_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0022type_selective_flush_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0023incomplete_add_set_command_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0025anonymous_set_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0026named_limit_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0027ipv6_maps_ipv4_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0028autoselect_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0028delete_handle_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0032restore_set_simple_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0033add_set_simple_flat_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0034get_element_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0035add_set_elements_flat_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0037_set_with_inet_service_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0038meter_list_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0039delete_interval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0040get_host_endian_elements_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0041interval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0042update_set_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0043concatenated_ranges_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0043concatenated_ranges_1.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0044interval_overlap_1.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0045concat_ipv4_service.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0046netmap_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0048set_counters_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0049set_define_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0050set_define_1.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0051set_interval_counter_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0052overlap_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0053echo_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0054comments_set_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0055tcpflags_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0056dynamic_limit_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0057set_create_fails_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0058_setupdate_timeout_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0059set_update_multistmt_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0060set_multistmt_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0060set_multistmt_1.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0061anonymous_automerge_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0062set_connlimit_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0063set_catchall_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0064map_catchall_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0065_icmp_postprocessing.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0069interval_merge_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0071unclosed_prefix_interval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0072destroy_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0073flat_interval_set.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/0074nested_interval_set.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/collapse_elem_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/concat_interval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/dynset_missing.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/errors_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/exact_overlap_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/inner_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/set_eval_0.json-nft
 create mode 100644 tests/shell/testcases/sets/dumps/type_set_symbol.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0001table_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0002table_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0003table_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0010chain_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0011chain_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0012chain_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0013chain_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0014chain_1.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0015chain_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0020rule_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0021rule_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0022rule_1.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0023rule_1.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0024rule_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0025rule_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0030set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0031set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0032set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0033set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0034set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0035set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0036set_1.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0037set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0038set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0039set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0040set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0041nat_restore_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0042_stateful_expr_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0043set_1.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0044rule_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0045anon-unbind_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0046set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0047set_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0048helpers_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0049huge_0.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/0050rule_1.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/30s-stress.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/anon_chain_loop.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/bad_expression.json-nft
 create mode 100644 tests/shell/testcases/transactions/dumps/table_onoff.json-nft

-- 
2.41.0

