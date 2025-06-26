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
  id 842
  arrival_time 17504.066872524963
  lifetime 1693.070043198878
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 43
    gpu 32
    rom 41
  ]
  node [
    id 1
    label "1"
    cpu 8
    gpu 1
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 31
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 43
    gpu 5
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 18
    gpu 44
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 4
    rom 36
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 23
    rom 2
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 30
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 14
    gpu 9
    rom 50
  ]
  node [
    id 9
    label "9"
    cpu 5
    gpu 10
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 12
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 19
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 6
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 21
  ]
]
