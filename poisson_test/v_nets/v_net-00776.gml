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
  id 776
  arrival_time 16169.095916527995
  lifetime 580.912893966551
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 27
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 9
    gpu 37
    rom 49
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 14
    rom 17
  ]
  node [
    id 3
    label "3"
    cpu 9
    gpu 21
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 38
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 15
    rom 49
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 36
    rom 38
  ]
  edge [
    source 0
    target 1
    bw 13
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 31
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 41
  ]
  edge [
    source 5
    target 6
    bw 36
  ]
]
