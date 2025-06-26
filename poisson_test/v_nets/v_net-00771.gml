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
  id 771
  arrival_time 16130.049137308342
  lifetime 810.2946544706164
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 35
    gpu 33
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 12
    gpu 32
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 10
    gpu 27
    rom 6
  ]
  node [
    id 3
    label "3"
    cpu 25
    gpu 8
    rom 27
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 30
    rom 43
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 4
    rom 29
  ]
  node [
    id 6
    label "6"
    cpu 41
    gpu 36
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 41
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 23
  ]
  edge [
    source 5
    target 6
    bw 4
  ]
]
