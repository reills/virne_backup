graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1570
  arrival_time 35024.172154730855
  lifetime 844.403475929228
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 1
    gpu 41
    rom 15
  ]
  node [
    id 1
    label "1"
    cpu 46
    gpu 6
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 7
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 19
    gpu 40
    rom 3
  ]
  node [
    id 4
    label "4"
    cpu 1
    gpu 22
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 16
    rom 41
  ]
  node [
    id 6
    label "6"
    cpu 18
    gpu 36
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 19
    gpu 14
    rom 15
  ]
  edge [
    source 0
    target 1
    bw 18
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 18
  ]
]
