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
  id 256
  arrival_time 4873.342182417173
  lifetime 2978.8811124535914
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 32
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 35
    rom 30
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 12
    rom 5
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 35
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 17
    rom 14
  ]
  node [
    id 5
    label "5"
    cpu 29
    gpu 47
    rom 48
  ]
  node [
    id 6
    label "6"
    cpu 23
    gpu 40
    rom 43
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 23
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 47
    rom 12
  ]
  node [
    id 9
    label "9"
    cpu 28
    gpu 32
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 48
    gpu 12
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 35
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 8
  ]
  edge [
    source 7
    target 8
    bw 24
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 4
  ]
]
